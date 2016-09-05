//
//  NSDate+Extra.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <Foundation/Foundation.h>

/// NSDate (Extra)
@interface NSDate (Extra)

+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format;

- (NSString *)stringWithFormat:(NSString *)format;

- (NSDate *)nextDay; // 后一天
- (NSDate *)prevDay; // 前一天

- (BOOL)isToday; // 今天
- (BOOL)isTomorrow; // 明天
- (BOOL)isYesterday; // 昨天
- (BOOL)isDayAfterTomorrow; // 后天
- (BOOL)isDayBeforeYesterday; // 前天

@end

// yyyy-MM-dd HH:mm:ss
extern NSString *const NSDateExtraFormatDatetime;
// yyyy-MM-dd
extern NSString *const NSDateExtraFormatDate;
// HH:mm:ss
extern NSString *const NSDateExtraFormatTime;

