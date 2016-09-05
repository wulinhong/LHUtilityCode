//
//  NSURLSessionManager.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NSURLSessionSuccessBlock)(NSHTTPURLResponse *response, NSData *data);
typedef void (^NSURLSessionFailureBlock)(NSHTTPURLResponse *response, NSError *error);

@interface NSURLSessionManager : NSObject
@property (nonatomic, assign) NSTimeInterval timeoutInterval; // Default 30 secondes

+ (NSURLSessionManager *)defaultManager;

- (void)getWithURL:(NSString *)url params:(NSDictionary *)params headers:(NSDictionary *)header success:(NSURLSessionSuccessBlock)success failure:(NSURLSessionFailureBlock)failure;

- (void)postWithURL:(NSString *)url params:(NSDictionary *)params headers:(NSDictionary *)header body:(NSData *)body success:(NSURLSessionSuccessBlock)success failure:(NSURLSessionFailureBlock)failure;

@end

