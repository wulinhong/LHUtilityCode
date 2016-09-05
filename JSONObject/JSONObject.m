//
//  JSONObject.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "JSONObject.h"

@implementation JSONObject

+ (BOOL)isValidJSONObject:(id)obj {
    return [NSJSONSerialization isValidJSONObject:obj];
}

+ (NSData *)dataWithJSONObject:(id)obj {
    NSData *data = nil;
    if ([JSONObject isValidJSONObject:obj]) {
        NSError *error;
        data = [NSJSONSerialization dataWithJSONObject:obj options:kNilOptions error:&error];
        if (data == nil) {
            NSLog(@"dataWithJSONObject failed with error: %@", error.localizedDescription);
        }
    }
    return data;
}

+ (NSString *)stringWithJSONObject:(id)obj {
    NSData *jsonData = [JSONObject dataWithJSONObject:obj];
    if (jsonData) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (id)JSONObjectWithData:(NSData *)data {
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (object == nil) {
        NSLog(@"JSONObjectWithData failed with error: %@", error.localizedDescription);
    }
    return object;
}

+ (id)JSONObjectWithString:(NSString *)str {
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [JSONObject JSONObjectWithData:data];
}

@end
