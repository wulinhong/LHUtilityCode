//
//  NSObject+PerformAction.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformAction)

- (BOOL)canPerformAction:(SEL)selector;

- (void)performAction:(SEL)selector;
- (void)performAction:(SEL)selector withObject:(id)object;
- (void)performAction:(SEL)selector withObject:(id)object1 withObject2:(id)object2;

@end
