//
//  UIColor.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "UIColor+Extra.h"

UIColor* UIColorFromRGB(NSUInteger value) {
    CGFloat a = 1.f;
    if ((value & 0xff000000)) {
        a = ((value & 0xff000000) >> 24) / 255.f;
    }
    CGFloat r = ((value & 0x00ff0000) >> 16) / 255.f;
    CGFloat g = ((value & 0x0000ff00) >> 8) / 255.f;
    CGFloat b = (value & 0x000000ff) / 255.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

UIColor* UIColorFromHEX(NSString *string) {
    NSRange range = [string rangeOfString:@"[A-Fa-f0-9]{6,8}" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        unsigned int hex = 0;
        NSString *str = [string substringWithRange:range];
        [[NSScanner scannerWithString:str] scanHexInt:&hex];
        return UIColorFromRGB(hex);
    }
    return [UIColor clearColor];
}

@implementation UIColor (Extra)

+ (instancetype)colorWithRGB:(NSUInteger)value {
    return UIColorFromRGB(value);
}

+ (instancetype)colorWithHEX:(NSString *)string {
    return UIColorFromHEX(string);
}

@end
