//
//  BDLocation.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <CoreLocation/CoreLocation.h>

@interface BDLocation : JSONModel
@property (nonatomic, strong) NSString<Optional> *address; // 地址
@property (nonatomic, strong) NSString<Optional> *name; // 名称
@property (nonatomic, strong) NSString<Optional> *city; // 城市
@property (nonatomic, strong) NSString<Optional> *cityCode; // 城市编码
@property (nonatomic, strong) NSString<Optional> *country; // 国家
@property (nonatomic, strong) NSString<Optional> *countryCode; // 国家编码
@property (nonatomic, strong) NSString<Optional> *district; // 地区
@property (nonatomic, strong) NSString<Optional> *province; // 省份
@property (nonatomic, strong) NSString<Optional> *street; // 街道
@property (nonatomic, strong) NSString<Optional> *streetNumber; // 街道编号
@property (nonatomic, assign) CLLocationDegrees latitude; // 纬度
@property (nonatomic, assign) CLLocationDegrees longitude; // 经度

- (instancetype)initWithLatitude:(CLLocationDegrees)latitude
                       longitude:(CLLocationDegrees)longitude;

- (instancetype)initWithLatitude:(CLLocationDegrees)latitude
                       longitude:(CLLocationDegrees)longitude
                         address:(NSString *)address
                            name:(NSString *)name;

// 获取地址名称
- (NSString *)addressName;

// 获取经纬度坐标
- (CLLocationCoordinate2D)coordinate;

@end

