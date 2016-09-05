//
//  NSData+Base64Encoding.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "NSData+Base64Encoding.h"

@implementation NSData (Base64Encoding)

+ (instancetype)dataWithBase64EncodedString:(NSString *)base64String options:(NSDataBase64DecodingOptions)options {
    if (base64String) {
        return [[NSData alloc] initWithBase64EncodedString:base64String options:options];
    }
    return nil;
}

- (NSString *)base64DecodedStringWithOptions:(NSDataBase64DecodingOptions)options {
    NSData *data = [self base64DecodedDataWithOptions:options];
    if (data) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (instancetype)dataWithBase64EncodedData:(NSData *)base64Data options:(NSDataBase64DecodingOptions)options {
    return [base64Data base64DecodedDataWithOptions:options];
}

- (NSData *)base64DecodedDataWithOptions:(NSDataBase64DecodingOptions)options {
    return [[NSData alloc] initWithBase64EncodedData:self options:options];
}


@end
