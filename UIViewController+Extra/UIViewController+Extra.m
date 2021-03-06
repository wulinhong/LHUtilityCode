//
//  UIViewController+Extra.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "UIViewController+Extra.h"

@implementation UIViewController (Extra)

#pragma mark - Back Bar Button Item

- (void)setBackItemImage:(UIImage *)image {
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                             style:self.navigationItem.backBarButtonItem.style
                                                                            target:self
                                                                            action:@selector(onBack:)];
}

- (void)setBackItemImage:(UIImage *)image title:(NSString *)title {
    //
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.tintColor = self.navigationController.navigationBar.tintColor;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
    button.frame = CGRectMake(0, 0, size.width + image.size.width, self.navigationController.navigationBar.frame.size.height);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:button.tintColor forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    [button addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    //
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setBackItemTitle:(NSString *)title {
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                             style:self.navigationItem.backBarButtonItem.style
                                                                            target:self
                                                                            action:@selector(onBack:)];
}

- (void)setBackItemTarget:(id)target action:(SEL)action {
    if ([self.navigationItem.leftBarButtonItem.customView isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
        [button.allTargets enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
            id target = obj;
            NSArray *actions = [button actionsForTarget:obj forControlEvent:UIControlEventTouchUpInside];
            [actions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SEL action = NSSelectorFromString(obj);
                [button removeTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            }];
        }];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.navigationItem.leftBarButtonItem.target = target;
        self.navigationItem.leftBarButtonItem.action = action;
    }
}

- (void)setBackItemTintColor:(UIColor *)color {
    if ([self.navigationItem.leftBarButtonItem.customView isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
        button.tintColor = color;
    } else {
        self.navigationItem.leftBarButtonItem.tintColor = color;
    }
}

#pragma mark - Title

- (void)setTitleFont:(UIFont *)font {
    NSMutableDictionary *attributes = [self.navigationController.navigationBar.titleTextAttributes mutableCopy];
    if (font) {
        if (attributes == nil) {
            attributes = [NSMutableDictionary dictionary];
        }
        [attributes setObject:font forKey:NSFontAttributeName];
    } else if (attributes) {
        [attributes removeObjectForKey:NSFontAttributeName];
    }
    self.navigationController.navigationBar.titleTextAttributes = attributes;
}

- (void)setTitleColor:(UIColor *)color {
    NSMutableDictionary *attributes = [self.navigationController.navigationBar.titleTextAttributes mutableCopy];
    if (color) {
        if (attributes == nil) {
            attributes = [NSMutableDictionary dictionary];
        }
        [attributes setObject:color forKey:NSForegroundColorAttributeName];
    } else if (attributes) {
        [attributes removeObjectForKey:NSForegroundColorAttributeName];
    }
    self.navigationController.navigationBar.titleTextAttributes = attributes;
}

#pragma mark - Top-Level View Controller

- (UIViewController *)topLevelViewController {
    if ([self isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController *)self).topViewController.topLevelViewController;
    } else if ([self isKindOfClass:[UITabBarController class]]) {
        return ((UITabBarController *)self).selectedViewController.topLevelViewController;
    } else if (self.presentedViewController) {
        if ([self.presentedViewController isBeingDismissed] ||
            [self.presentedViewController isMovingFromParentViewController]) {
            return self;
        }
        return [self.presentedViewController topLevelViewController];
    }
    return self;
}

#pragma mark Target Actions

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 显示/隐藏 状态栏
    [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
    // 显示/隐藏 导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 自定导航栏颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // 导航栏透明并取消分隔线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    // 只显示文字
    [self setBackItemTitle:@"返回"];
    // 只显示图标
    [self setBackItemImage:[UIImage imageNamed:@"返回按钮"]];
    // 显示图标和文字
    [self setBackItemImage:[UIImage imageNamed:@"返回按钮"] title:@"返回"];
}

#pragma mark - Status Bar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO; // 显示/隐藏 状态栏
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}*/

@end

@implementation UINavigationController (Extra)

- (UIViewController *)prevViewController {
    if (self.topViewController) {
        NSInteger index = [self.viewControllers indexOfObject:self.topViewController] - 1;
        if (index >= 0) {
            return self.viewControllers[index];
        }
    }
    return nil;
}

- (UIViewController *)rootViewController {
    return [self.viewControllers firstObject];
}

@end
