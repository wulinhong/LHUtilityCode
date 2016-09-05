//
//  ZXBadgeLabel.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ZXBadgeLabel : UILabel

// audo-hide
@property (nonatomic, assign) IBInspectable BOOL audoHide;

// border
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

// badge number
@property (nonatomic, assign) IBInspectable NSUInteger number;
// eg. number>99, threshold==99, display as "99+"
@property (nonatomic, assign) IBInspectable NSUInteger threshold;

@end
