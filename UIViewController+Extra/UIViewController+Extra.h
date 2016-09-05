//
//  UIViewController+Extra.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extra) <UIGestureRecognizerDelegate>

- (void)setBackItemTitle:(NSString *)title;

- (void)setBackItemImage:(UIImage *)image;
- (void)setBackItemImage:(UIImage *)image title:(NSString *)title;

- (void)setBackItemTarget:(id)target action:(SEL)action;

- (void)setBackItemTintColor:(UIColor *)color;

- (void)setTitleFont:(UIFont *)font;
- (void)setTitleColor:(UIColor *)color;

- (UIViewController *)topLevelViewController;

@end

@interface UINavigationController (Extra)

- (UIViewController *)prevViewController;
- (UIViewController *)rootViewController;

@end
