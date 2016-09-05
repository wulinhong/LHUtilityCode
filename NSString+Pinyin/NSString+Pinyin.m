//
//  NSString+Pinyin.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "NSString+Pinyin.h"

BOOL NSStringContainsChineseCharacters(NSString *string) {
    for(NSUInteger i = 0; i < string.length; ++i) {
        unichar c = [string characterAtIndex:i];
        if (c >= 0x4e00 && c <= 0x9ff5) {
            return YES;
        }
    }
    return NO;
}

BOOL NSStringContainsSubstring(NSString *string, NSString *substring, NSStringPinyinOptions options) {
    if (string.length > 0 && substring.length > 0) {
        if ([string rangeOfString:substring options:NSCaseInsensitiveSearch].location != NSNotFound) {
            return YES;
        }
        if ([string containsChineseCharacters]) {
            if ((options & NSStringPinyinSearchAcronym) > 0) {
                NSString *py = NSStringPinyinAcronym(string);
                if ([py rangeOfString:substring options:NSCaseInsensitiveSearch].location != NSNotFound) {
                    return YES;
                }
            }
            if ((options & NSStringPinyinSearchFully) > 0) {
                NSString *py = NSStringPinyinTransform(string, NSStringPinyinStripDiacritics);
                py = [py stringByReplacingOccurrencesOfString:@" " withString:@""]; // will be improvement
                if ([py rangeOfString:substring options:NSCaseInsensitiveSearch].location != NSNotFound) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

NSString* NSStringPinyinTransform(NSString *string, NSStringPinyinStyle style) {
    if ([string containsChineseCharacters]) {
        NSMutableString *py = [NSMutableString stringWithString:string];
        if (CFStringTransform((__bridge CFMutableStringRef)py, NULL, kCFStringTransformMandarinLatin, NO)) {
            if (style == NSStringPinyinMandarinLatin) {
                return py;
            }
            if (CFStringTransform((__bridge CFMutableStringRef)py, NULL, kCFStringTransformStripDiacritics, NO)) {
                return py;
            }
        }
    }
    return string;
}

NSString* NSStringPinyinAcronym(NSString *string) {
    NSString *pinyin = NSStringPinyinTransform(string, NSStringPinyinStripDiacritics);
    NSArray *strings = [pinyin componentsSeparatedByString:@" "];
    NSMutableString *str = [NSMutableString string];
    for (NSString *string in strings) {
        if (string.length > 0) {
            [str appendString:[string substringToIndex:1]];
        }
    }
    return str;
}

NSString* NSStringPinyinFirstLetter(NSString *string) {
    NSString *initial = nil;
    if (string.length > 0) {
        NSString *str = [string substringToIndex:1];
        NSString *py = NSStringPinyinTransform(str, NSStringPinyinStripDiacritics);
        if (py.length > 0) {
            initial = [py substringToIndex:1];
        }
    }
    return [initial uppercaseString];
}

#pragma mark - NSString (Pinyin)

@implementation NSString (Pinyin)

- (BOOL)containsChineseCharacters {
    return NSStringContainsChineseCharacters(self);
}

- (BOOL)containsString:(NSString *)string options:(NSStringPinyinOptions)options {
    return NSStringContainsSubstring(self, string, options);
}

- (NSString *)stringByPinyinStyle:(NSStringPinyinStyle)style {
    return NSStringPinyinTransform(self, style);
}

- (NSString *)stringByPinyinAcronym {
    return NSStringPinyinAcronym(self);
}

- (NSString *)stringByPinyinFirstLetter {
    return NSStringPinyinFirstLetter(self);
}

@end
