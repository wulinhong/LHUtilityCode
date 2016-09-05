//
//  ZXRefreshHeaderView.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^ZXRefreshHeaderBlock)(void);

typedef NS_ENUM(NSInteger, ZXRefreshState)
{
    ZXRefreshStateIdle,
    ZXRefreshStatePulling,
    ZXRefreshStateWillRefreshing,
    ZXRefreshStateRefreshing,
};

@protocol ZXRefreshHeaderProtocol <NSObject>

- (BOOL)attachToView:(UIView *)view;
- (BOOL)detach;

- (void)setPullingProgress:(CGFloat)progress;

- (BOOL)beginRefreshing;
- (BOOL)endRefreshing;

- (void)updateContentSize;

@end

@interface ZXRefreshHeaderView : UIView <ZXRefreshHeaderProtocol>
@property (nonatomic, assign) CGFloat contentHeight; // Default 40
@property (nonatomic, assign) CGFloat contentInset;  // Default 0
@property (nonatomic, assign) CGFloat contentOffset; // Default 0

+ (instancetype)headerWithRefreshingBlock:(ZXRefreshHeaderBlock)block;

- (BOOL)isRefreshing;

@end

@interface UIView (ZXRefreshHeaderView)
@property (nonatomic, strong) ZXRefreshHeaderView *refreshHeaderView;
@end
