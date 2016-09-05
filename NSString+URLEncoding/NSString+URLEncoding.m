//
//  NSString+URLEncoding.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "NSString+URLEncoding.h"

NSString *NSStringWithURLEncoding(NSString *string, NSStringEncoding encoding) {
    NSString *str = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(encoding)));
    return str;
}

@implementation NSString (URLEncode)

- (NSString*)stringByURLEncoding:(NSStringEncoding)encoding {
    return NSStringWithURLEncoding(self, encoding);
}
@end
