//
//  ZXTabBarController.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "ZXTabBarController.h"

@interface ZXTabBarController ()

@end

@implementation ZXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // view controllers
    NSMutableArray *viewControllers = [NSMutableArray array];
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = obj;
        if ([obj isKindOfClass:[ZXTabBarItemController class]]) {
            ZXTabBarItemController *item = obj;
            if (item.storyboardName) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:item.storyboardName bundle:nil];
                if (item.storyboardID) {
                    vc = [sb instantiateViewControllerWithIdentifier:item.storyboardID];
                } else {
                    vc = [sb instantiateInitialViewController];
                }
                vc.tabBarItem = item.tabBarItem;
            }
        }
        [viewControllers addObject:vc];
    }];
    [self setViewControllers:viewControllers animated:NO];
    
    // tabBar
    if (_selectedItemColor) {
        self.tabBar.tintColor = _selectedItemColor;
    }
    
    // tabBar items
    if (_originalItemImage) {
        [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.image = [obj.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            obj.selectedImage = [obj.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation ZXTabBarItemController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
