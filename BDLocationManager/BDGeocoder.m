//
//  BDGeocoder.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "BDGeocoder.h"
#import <JSONModelLib.h>

@implementation BDGeocoder

- (void)geocodeLocation:(BDLocation *)location completion:(BDGeocodeCompletion)completion {
    NSString *address = location.addressName;
    if (address == nil || address.length == 0) {
        if (completion) {
            completion(nil, [JSONModelError errorInputIsNil]);
        }
        return;
    }
    NSDictionary *params = @{@"ak":BAIDU_APPKEY,
                             @"mcode":BAIDU_MCODE,
                             @"address":address,
                             @"city":location.city ? location.city : @"",
                             @"output":@"json",
                             @"pois":@"1"};
    [JSONHTTPClient getJSONFromURLWithString:@"http://api.map.baidu.com/geocoder/v2/?" params:params completion:^(id json, JSONModelError *err) {
        NSDictionary *dict = (NSDictionary *)json;
        int status = [dict[@"status"] intValue];
        if (status == 0) {
            NSMutableArray *array = [NSMutableArray array];
            NSDictionary *result = dict[@"result"];
            // location
            BDLocation *obj = [location copy];
            obj.latitude = [result[@"location"][@"lat"] doubleValue];
            obj.longitude = [result[@"location"][@"lng"] doubleValue];
            [array addObject:obj];
            // completion
            if (completion) {
                completion(array, err);
            }
        } else if (completion) {
            // error
            completion(nil, err);
        }
    }];
}

- (void)reverseGeocodeLocation:(BDLocation *)location completion:(BDGeocodeCompletion)completion {
    NSDictionary *params = @{@"ak":BAIDU_APPKEY,
                             @"mcode":BAIDU_MCODE,
                             @"location":[NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude],
                             @"coordtype":@"bd09ll",
                             @"output":@"json",
                             @"pois":@"1"};
    [JSONHTTPClient getJSONFromURLWithString:@"http://api.map.baidu.com/geocoder/v2/?" params:params completion:^(id json, JSONModelError *err) {
        NSDictionary *dict = (NSDictionary *)json;
        int status = [dict[@"status"] intValue];
        if (status == 0) {
            NSMutableArray *locations = [NSMutableArray array];
            NSDictionary *result = dict[@"result"];
            // location
            BDLocation *location = [[BDLocation alloc] init];
            location.address = result[@"formatted_address"];
            location.city = result[@"addressComponent"][@"city"];
            location.cityCode = result[@"cityCode"];
            location.country = result[@"addressComponent"][@"country"];
            location.countryCode = result[@"addressComponent"][@"country_code"];
            location.district = result[@"addressComponent"][@"district"];
            location.province = result[@"addressComponent"][@"province"];
            location.street = result[@"addressComponent"][@"street"];
            location.streetNumber = result[@"addressComponent"][@"street_number"];
            location.latitude = [result[@"location"][@"lat"] doubleValue];
            location.longitude = [result[@"location"][@"lng"] doubleValue];
            [locations addObject:location];
            // pois
            NSArray *pois = result[@"pois"];
            [pois enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *poi = obj;
                if (location.name == nil && [poi[@"addr"] isEqualToString:location.address]) {
                    location.name = poi[@"name"];
                } else {
                    BDLocation *location = [[BDLocation alloc] init];
                    location.longitude = [poi[@"point"][@"x"] doubleValue];
                    location.latitude = [poi[@"point"][@"y"] doubleValue];
                    location.address = poi[@"addr"];
                    location.name = poi[@"name"];
                    [locations addObject:location];
                }
            }];
            // completion
            if (completion) {
                completion(locations, err);
            }
        } else if (completion) {
            // error
            completion(nil, err);
        }
    }];
}

@end
