//
//  ZXCircularProgressHeader.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "ZXRefreshHeaderView.h"

@class ZXCircularProgressView;

/// 环形进度刷新视图
@interface ZXCircularProgressHeader : ZXRefreshHeaderView
/// 环形进度视图
@property (nonatomic, strong) ZXCircularProgressView *progressView;
/// 环形半径, 默认 16
@property (nonatomic, assign) CGFloat circularRadius;
/// 动画时间, 默认 0.8秒
@property (nonatomic, assign) CGFloat animationDuration;

@end

/// 环形进度视图
@interface ZXCircularProgressView : UIView
/// 闭合完整度，默认 0.8
@property (nonatomic, assign) CGFloat integrity;
/// 线宽，默认 1.5
@property (nonatomic, assign) CGFloat lineWidth;
/// 进度，范围 0.0 - 1.0
@property (nonatomic, assign) CGFloat progress;
/// 进度颜色
@property (nonatomic, copy) UIColor *progressColor;

@end

