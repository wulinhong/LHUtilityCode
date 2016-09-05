//
//  NSString+HashValue.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "NSString+HashValue.h"

@implementation NSString (HashValue)

- (NSData *)MD5Data {
    const char *data = [self UTF8String];
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data, (CC_LONG)strlen(data), bytes);
    return [NSData dataWithBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)MD5String {
    const char *data = [self UTF8String];
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data, (CC_LONG)strlen(data), bytes);
    //
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [string appendFormat:@"%02x", bytes[i]];
    }
    return string;
}

- (NSData *)SHA1Data {
    const char *data = [self UTF8String];
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data, (CC_LONG)strlen(data), bytes);
    return [NSData dataWithBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)SHA1String {
    const char *data = [self UTF8String];
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data, (CC_LONG)strlen(data), bytes);
    //
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [string appendFormat:@"%02x", bytes[i]];
    }
    return string;
}

@end
