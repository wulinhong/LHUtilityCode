//
//  QRCodeGenerator.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeGenerator : NSObject

+ (UIImage *)imageWithData:(NSData *)data size:(CGFloat)size;
+ (UIImage *)imageWithData:(NSData *)data size:(CGFloat)size color:(UIColor *)color;

+ (UIImage *)imageWithString:(NSString *)string size:(CGFloat)size;
+ (UIImage *)imageWithString:(NSString *)string size:(CGFloat)size color:(UIColor *)color;

@end
