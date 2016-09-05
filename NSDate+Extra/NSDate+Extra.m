//
//  NSDate+Extra.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "NSDate+Extra.h"

NSString *const NSDateExtraFormatDatetime   = @"yyyy-MM-dd HH:mm:ss";
NSString *const NSDateExtraFormatDate       = @"yyyy-MM-dd";
NSString *const NSDateExtraFormatTime       = @"HH:mm:ss";

@implementation NSDate (Extra)

+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en"]];
    if (format) {
        [dateFormatter setDateFormat:format];
    } else {
        [dateFormatter setDateFormat:NSDateExtraFormatDatetime];
    }
    return [dateFormatter dateFromString:string];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en"]];
    if (format) {
        [dateFormatter setDateFormat:format];
    } else {
        [dateFormatter setDateFormat:NSDateExtraFormatDatetime];
    }
    NSString *string = [dateFormatter stringFromDate:self];
    return string;
}

- (NSDate *)nextDay {
    return [NSDate dateWithTimeIntervalSinceReferenceDate:[self timeIntervalSinceReferenceDate] + 24 * 3600];
}

- (NSDate *)prevDay {
    return [NSDate dateWithTimeIntervalSinceReferenceDate:[self timeIntervalSinceReferenceDate] - 24 * 3600];
}

- (BOOL)isToday {
    NSString *date = [[NSDate date] stringWithFormat:NSDateExtraFormatDate];
    return [date isEqualToString:[self stringWithFormat:NSDateExtraFormatDate]];
}

- (BOOL)isTomorrow {
    NSString *date = [[[NSDate date] nextDay] stringWithFormat:NSDateExtraFormatDate];
    return [date isEqualToString:[self stringWithFormat:NSDateExtraFormatDate]];
}

- (BOOL)isYesterday {
    NSString *date = [[[NSDate date] prevDay] stringWithFormat:NSDateExtraFormatDate];
    return [date isEqualToString:[self stringWithFormat:NSDateExtraFormatDate]];
}

- (BOOL)isDayAfterTomorrow {
    NSString *date = [[NSDate dateWithTimeIntervalSinceReferenceDate:[[NSDate date] timeIntervalSinceReferenceDate] + 48 * 3600] stringWithFormat:NSDateExtraFormatDate];
    return [date isEqualToString:[self stringWithFormat:NSDateExtraFormatDate]];
}

- (BOOL)isDayBeforeYesterday {
    NSString *date = [[NSDate dateWithTimeIntervalSinceReferenceDate:[[NSDate date] timeIntervalSinceReferenceDate] - 48 * 3600] stringWithFormat:NSDateExtraFormatDate];
    return [date isEqualToString:[self stringWithFormat:NSDateExtraFormatDate]];
}

@end
