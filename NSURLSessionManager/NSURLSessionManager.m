//
//  NSURLSessionManager.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "NSURLSessionManager.h"

@interface NSURLSessionManager ()
@property (nonatomic, strong) dispatch_queue_t taskQueue;

- (void)requestWithURL:(NSString *)url params:(NSDictionary *)params method:(NSString *)method headers:(NSDictionary *)headers body:(NSData *)body success:(NSURLSessionSuccessBlock)success failure:(NSURLSessionFailureBlock)failure;

@end

@implementation NSURLSessionManager

static NSURLSessionManager *_defaultManager = nil;

+ (NSURLSessionManager *)defaultManager {
    if (_defaultManager == nil) {
        _defaultManager = [[NSURLSessionManager alloc] init];
    }
    return _defaultManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timeoutInterval = 30.f;
        self.taskQueue = dispatch_queue_create("NSURLSessionManager", NULL);
    }
    return self;
}

#pragma mark HTTP Method

- (void)requestWithURL:(NSString *)url params:(NSDictionary *)params method:(NSString *)method headers:(NSDictionary *)headers body:(NSData *)body success:(NSURLSessionSuccessBlock)success failure:(NSURLSessionFailureBlock)failure {
    //
    dispatch_async(self.taskQueue, ^{
        // url
        NSString *urlString = url;
        // params
        if (params.count > 0) {
            NSMutableArray *pairs = [[NSMutableArray alloc] init];
            [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSString *pair = [NSString stringWithFormat:@"%@=%@", key, obj];
                [pairs addObject:pair];
            }];
            // query
            NSString *query = [pairs componentsJoinedByString:@"&"];
            if (query) {
                urlString = [url stringByAppendingFormat:@"?%@", query];
            }
        }
        // request
        NSMutableURLRequest *reqeust = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        reqeust.HTTPMethod = method;
        reqeust.HTTPBody = body;
        reqeust.timeoutInterval = self.timeoutInterval;
        // header fields
        [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [reqeust setValue:obj forHTTPHeaderField:key];
        }];
        // task
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:reqeust completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@ %@\nRET %@(%d)", method, urlString, error.localizedDescription, (int)error.code);
                if (failure) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failure((NSHTTPURLResponse *)response, error);
                    });
                }
            } else {
                id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                if (obj == nil) {
                    obj = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                }
                if (obj == nil) {
                    obj = [NSString stringWithFormat:@"<Unknown data, length: %d bytes>", (int)data.length];
                }
                NSLog(@"%@ %@\nRET %@", method, urlString, obj);
                if (success) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success((NSHTTPURLResponse *)response, data);
                    });
                }
            }
        }];
        [task resume];
    });
}

- (void)getWithURL:(NSString *)url params:(NSDictionary *)params headers:(NSDictionary *)headers success:(NSURLSessionSuccessBlock)success failure:(NSURLSessionFailureBlock)failure {
    [self requestWithURL:url params:params method:@"GET" headers:headers body:nil success:success failure:failure];
}

- (void)postWithURL:(NSString *)url params:(NSDictionary *)params headers:(NSDictionary *)headers body:(NSData *)body success:(NSURLSessionSuccessBlock)success failure:(NSURLSessionFailureBlock)failure {
    [self requestWithURL:url params:params method:@"POST" headers:headers body:body success:success failure:failure];
}

@end

