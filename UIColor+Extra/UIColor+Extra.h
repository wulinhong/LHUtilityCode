//
//  UIColor.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Make color from integer with ARGB format.
 * eg. 0xffffffff or 0xffffff or 0xff etc.
 */
UIKIT_EXTERN UIColor* UIColorFromRGB(NSUInteger value);

/**
 * Make color from string with ARGB format, The value must be between 6 and 8 characters.
 * eg. @"ffffffff" or @"0xffffffff" or @"#ffffff" etc.
 */
UIKIT_EXTERN UIColor* UIColorFromHEX(NSString *string);

/**
 * UIColor Extra
 */
@interface UIColor (Extra)

/**
 * Make color from integer with ARGB format.
 * Same as UIColorFromRGB().
 */
+ (instancetype)colorWithRGB:(NSUInteger)value;

/**
 * Make color from string with ARGB format, The value must be between 6 and 8 characters.
 * Same as UIColorFromHEX().
 */
+ (instancetype)colorWithHEX:(NSString *)string;

@end
