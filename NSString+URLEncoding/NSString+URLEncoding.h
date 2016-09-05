//
//  NSString+URLEncoding.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *NSStringWithURLEncoding(NSString *string, NSStringEncoding encoding);

@interface NSString (URLEncoding)

- (NSString*)stringByURLEncoding:(NSStringEncoding)encoding;

@end
