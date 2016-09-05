//
//  NSArray+ObjectByIndex.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ObjectByIndex)

/// Same as [NSArray objectAtIndex:]
- (id)objectByIndex:(NSUInteger)index;

@end

@interface NSMutableArray (ObjectByIndex)

@end

