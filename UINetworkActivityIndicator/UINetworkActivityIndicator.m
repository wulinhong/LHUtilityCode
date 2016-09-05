//
//  UINetworkActivityIndicator.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "UINetworkActivityIndicator.h"

@implementation UINetworkActivityIndicator

/// 网络活动数量，大于0则显示网络指示器，等于0则隐藏指示器
static NSInteger __networkActivityCount = 0;

+ (void)showNetworkActivityIndicator {
    __networkActivityCount++;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = __networkActivityCount > 0;
}

+ (void)hideNetworkActivityIndicator {
    if (__networkActivityCount > 0) {
        __networkActivityCount--;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = __networkActivityCount > 0;
    }
}

@end
