//
//  UIButton.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extra)

// 设置左字右图
- (void)setForceRightToLeft:(CGFloat)spacing forState:(UIControlState)state;

@end
