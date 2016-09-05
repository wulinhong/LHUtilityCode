//
//  NSArray+ObjectByIndex.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "NSArray+ObjectByIndex.h"

@implementation NSArray (ObjectByIndex)

+ (void)load {
    Class class = objc_getClass("__NSArrayI");
    Method originalMethod = class_getInstanceMethod(class, @selector(objectAtIndex:));
    Method exchangeMethod = class_getInstanceMethod(class, @selector(objectByIndex:));
    method_exchangeImplementations(originalMethod, exchangeMethod);
}

- (id)objectByIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self objectByIndex:index];
    }
    return nil;
}

@end

@implementation NSMutableArray (ObjectByIndex)

+ (void)load {
    Class class = objc_getClass("__NSArrayM");
    Method originalMethod = class_getInstanceMethod(class, @selector(objectAtIndex:));
    Method exchangeMethod = class_getInstanceMethod(class, @selector(objectByIndex:));
    method_exchangeImplementations(originalMethod, exchangeMethod);
}

- (id)objectByIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self objectByIndex:index];
    }
    return nil;
}

@end