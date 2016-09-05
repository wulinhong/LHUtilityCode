//
//  dispatch_queue.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#ifndef __dispatch_queue__
#define __dispatch_queue__

#import <Foundation/Foundation.h>

#ifdef __BLOCKS__
__OSX_AVAILABLE_STARTING(__MAC_10_6,__IPHONE_4_0)
DISPATCH_EXPORT DISPATCH_NONNULL_ALL DISPATCH_NOTHROW
void dispatch_async_global_queue(dispatch_block_t block);
void dispatch_async_main_queue(dispatch_block_t block);
void dispatch_sync_global_queue(dispatch_block_t block);
void dispatch_sync_main_queue(dispatch_block_t block);
void dispatch_after_global_queue(NSTimeInterval second, dispatch_block_t block);
void dispatch_after_main_queue(NSTimeInterval second, dispatch_block_t block);
#endif

#endif
