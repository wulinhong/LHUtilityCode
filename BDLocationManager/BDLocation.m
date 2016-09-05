//
//  BDLocation.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "BDLocation.h"

@implementation BDLocation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.latitude = kCLLocationCoordinate2DInvalid.latitude;
        self.longitude = kCLLocationCoordinate2DInvalid.longitude;
    }
    return self;
}

- (instancetype)initWithLatitude:(CLLocationDegrees)latitude
                       longitude:(CLLocationDegrees)longitude {
    self = [super init];
    if (self) {
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}

- (instancetype)initWithLatitude:(CLLocationDegrees)latitude
                       longitude:(CLLocationDegrees)longitude
                         address:(NSString *)address
                            name:(NSString *)name {
    self = [super init];
    if (self) {
        self.latitude = latitude;
        self.longitude = longitude;
        self.address = address;
        self.name = name;
    }
    return self;
}

- (NSString *)addressName {
    if (self.name.length > 0) {
        return self.name;
    }
    if (self.address.length > 0) {
        return self.address;
    }
    return nil;
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(_latitude, _longitude);
}

@end
