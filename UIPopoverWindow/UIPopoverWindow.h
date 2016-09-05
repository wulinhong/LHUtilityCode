//
//  UIPopoverWindow.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPopoverWindow : UIWindow
@property (nonatomic, readonly) UIView *popoverView;

- (void)presentView:(UIView *)view;
- (void)dismiss;

@end
