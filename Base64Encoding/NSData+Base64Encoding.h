//
//  NSData+Base64Encoding.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64Encoding)

+ (instancetype)dataWithBase64EncodedString:(NSString *)base64String options:(NSDataBase64DecodingOptions)options;
- (NSString *)base64DecodedStringWithOptions:(NSDataBase64DecodingOptions)options;

+ (instancetype)dataWithBase64EncodedData:(NSData *)base64Data options:(NSDataBase64DecodingOptions)options;
- (NSData *)base64DecodedDataWithOptions:(NSDataBase64DecodingOptions)options;

@end
