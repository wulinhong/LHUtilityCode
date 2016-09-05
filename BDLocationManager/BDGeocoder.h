//
//  BDGeocoder.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "BDLocation.h"

// 地理编码完成 block
typedef void (^BDGeocodeCompletion)(NSArray<BDLocation *> *locations, NSError *error);

// 地理编码器
@interface BDGeocoder : NSObject

// 正向地理编码，根据地址或名称返回经纬度
- (void)geocodeLocation:(BDLocation *)location completion:(BDGeocodeCompletion)completion;

// 反向地理编码，根据经纬度返回地址或名称
- (void)reverseGeocodeLocation:(BDLocation *)location completion:(BDGeocodeCompletion)completion;

@end
