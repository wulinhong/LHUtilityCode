//
//  NSObject+PerformAction.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "NSObject+PerformAction.h"

@implementation NSObject (PerformAction)

- (BOOL)canPerformAction:(SEL)selector {
    return selector && [self respondsToSelector:selector];
}

- (void)performAction:(SEL)selector {
    IMP imp = [self methodForSelector:selector];
    void (*func)(id, SEL) = (void *)imp;
    func(self, selector);
}

- (void)performAction:(SEL)selector withObject:(id)object {
    IMP imp = [self methodForSelector:selector];
    void (*func)(id, SEL, id) = (void *)imp;
    func(self, selector, object);
}

- (void)performAction:(SEL)selector withObject:(id)object1 withObject2:(id)object2 {
    IMP imp = [self methodForSelector:selector];
    void (*func)(id, SEL, id, id) = (void *)imp;
    func(self, selector, object1, object2);
}

@end
