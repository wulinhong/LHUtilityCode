//
//  NSString+Base64Encoding.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "NSString+Base64Encoding.h"
#import "NSData+Base64Encoding.h"

@implementation NSString (Base64Encoding)

+ (instancetype)stringWithBase64EncodedString:(NSString *)base64String options:(NSDataBase64DecodingOptions)options {
    return [base64String base64DecodedStringWithOptions:options];
}

- (NSString *)base64DecodedStringWithOptions:(NSDataBase64DecodingOptions)options {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64DecodedStringWithOptions:options];
}

- (NSString *)base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)options {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:options];
}

+ (instancetype)stringWithBase64EncodedData:(NSData *)base64Data options:(NSDataBase64DecodingOptions)options {
    return [base64Data base64DecodedStringWithOptions:options];
}

- (NSData *)base64DecodedDataWithOptions:(NSDataBase64DecodingOptions)options {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64DecodedDataWithOptions:options];
}

- (NSData *)base64EncodedDataWithOptions:(NSDataBase64EncodingOptions)options {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedDataWithOptions:options];
}

@end
