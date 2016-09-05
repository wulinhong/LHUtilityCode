//
//  BDLocationManager.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "BDLocation.h"

// BDLocationManager
@interface BDLocationManager : NSObject

// 位置信息
@property (nonatomic, strong) BDLocation *location;

// 单例
+ (BDLocationManager *)defaultManager;

// 定位服务
- (void)startLocationService;
- (void)stopLocationService;

// 更新位置
- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end

/**
 * @brief 位置更新通知
 * @param notification.userInfo = {@"location":BDLocation}
 */
extern NSString *const BDLocationManagerDidUpdateLocationNotification;
