//
//  NSFileManager+Extra.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Extra)

// Bundle
+ (NSString*)bundleFile:(NSString*)file;

// Caches
+ (NSString*)cachesDirectory;
+ (NSString*)cachesDirectory:(NSString *)subpath;
+ (NSString*)cachesFile:(NSString*)file;
+ (NSString*)cachesFile:(NSString*)file inDirectory:(NSString *)subpath;

// Documents
+ (NSString*)documentDirectory;
+ (NSString*)documentDirectory:(NSString *)subpath;
+ (NSString*)documentFile:(NSString*)file;
+ (NSString*)documentFile:(NSString *)file inDirectory:(NSString *)subpath;

// Temporary
+ (NSString *)temporaryDirectory;
+ (NSString *)temporaryDirectory:(NSString *)subpath;
+ (NSString *)temporaryFile:(NSString *)file;
+ (NSString *)temporaryFile:(NSString *)file inDirectory:(NSString *)subpath;

// File size
+ (uint64_t)fileSizeAtPath:(NSString *)path;

// Create && Remove
- (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError **)error;
- (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error exclude:(NSArray *)exclusions;

@end

