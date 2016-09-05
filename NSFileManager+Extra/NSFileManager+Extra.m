//
//  NSFileManager+Extra.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "NSFileManager+Extra.h"

@implementation NSFileManager (Extra)

+ (NSString*)bundleFile:(NSString*)file {
    return [[NSBundle mainBundle] pathForResource:[file stringByDeletingPathExtension] ofType:[file pathExtension]];
}

+ (NSString*)cachesDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    BOOL isDir = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir] && isDir == NO) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path error:nil];
    }
    return path;
}

+ (NSString*)cachesDirectory:(NSString *)subpath {
    NSString *path = [NSFileManager cachesDirectory];
    if (subpath.length > 0) {
        BOOL isDir = NO;
        path = [path stringByAppendingPathComponent:subpath];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir] && isDir == NO) {
            [[NSFileManager defaultManager] createDirectoryAtPath:path error:nil];
        }
    }
    return path;
}

+ (NSString*)cachesFile:(NSString*)file {
    NSString *path = [NSFileManager cachesDirectory];
    return [path stringByAppendingPathComponent:file];
}

+ (NSString*)cachesFile:(NSString*)file inDirectory:(NSString *)subpath {
    NSString *path = [NSFileManager cachesDirectory:subpath];
    return [path stringByAppendingPathComponent:file];
}

+ (NSString*)documentDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString*)documentDirectory:(NSString *)subpath {
    NSString *path = [NSFileManager documentDirectory];
    if (subpath.length > 0) {
        BOOL isDir = NO;
        path = [path stringByAppendingPathComponent:subpath];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir] && isDir == NO) {
            [[NSFileManager defaultManager] createDirectoryAtPath:path error:nil];
        }
    }
    return path;
}

+ (NSString*)documentFile:(NSString*)file {
    NSString *path = [NSFileManager documentDirectory];
    return [path stringByAppendingPathComponent:file];
}

+ (NSString*)documentFile:(NSString *)file inDirectory:(NSString *)subpath {
    NSString *path = [NSFileManager documentDirectory:subpath];
    return [path stringByAppendingPathComponent:file];
}

+ (NSString *)temporaryDirectory {
    return NSTemporaryDirectory();
}

+ (NSString*)temporaryDirectory:(NSString *)subpath {
    NSString *path = [NSFileManager temporaryDirectory];
    if (subpath.length > 0) {
        BOOL isDir = NO;
        path = [path stringByAppendingPathComponent:subpath];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir] && isDir == NO) {
            [[NSFileManager defaultManager] createDirectoryAtPath:path error:nil];
        }
    }
    return path;
}

+ (NSString *)temporaryFile:(NSString *)file {
    NSString *path = [NSFileManager temporaryDirectory];
    return [path stringByAppendingPathComponent:file];
}

+ (NSString *)temporaryFile:(NSString *)file inDirectory:(NSString *)subpath {
    NSString *path = [NSFileManager temporaryDirectory:subpath];
    return [path stringByAppendingPathComponent:file];
}

+ (uint64_t)fileSizeAtPath:(NSString *)path {
    __block uint64_t fileSize = 0;
    NSFileManager *manager = [NSFileManager defaultManager];
    [[manager subpathsAtPath:path] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isDir = NO;
        NSString *subpath = [path stringByAppendingPathComponent:obj];
        if ([manager fileExistsAtPath:subpath isDirectory:&isDir]) {
            if (!isDir) {
                NSError *error = nil;
                NSDictionary *fileAttributes = [manager attributesOfItemAtPath:subpath error:&error];
                if (error) {
                    NSLog(@"%@", error.localizedDescription);
                } else {
                    fileSize += [fileAttributes fileSize];
                }
            }
        }
    }];
    return fileSize;
}

- (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError **)error {
    return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
}

- (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error exclude:(NSArray *)exclusions {
    BOOL isDir = NO;
    if ([self fileExistsAtPath:path isDirectory:&isDir]) {
        if (isDir) {
            NSDirectoryEnumerator *enumerator = [self enumeratorAtPath:path];
            NSString *subpath = nil;
            while (subpath = [enumerator nextObject]) {
                if ([exclusions containsObject:subpath]) {
                    continue;
                }
                [self removeItemAtPath:[path stringByAppendingPathComponent:subpath]
                                 error:error
                               exclude:exclusions];
            }
        }
        if (![exclusions containsObject:[path lastPathComponent]]) {
            return [self removeItemAtPath:path error:error];
        }
    }
    return NO;
}

@end
