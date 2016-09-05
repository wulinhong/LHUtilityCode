//
//  ZXCycleView.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXCycleView;

@protocol ZXCycleViewDelegate <NSObject, UIScrollViewDelegate>
@required
- (UIView *)cycleView:(ZXCycleView *)cycleView viewForPageAtIndex:(NSInteger)index;
@optional
- (void)cycleView:(ZXCycleView *)cycleView willDisplayView:(UIView *)pageView forPageAtIndex:(NSInteger)index;
@end

typedef NS_ENUM(NSInteger, ZXCycleViewDirection) {
    ZXCycleViewDirectionHorizontal,
    ZXCycleViewDirectionVertical,
};

@interface ZXCycleView : UIScrollView
@property (nonatomic, weak) id <ZXCycleViewDelegate> delegate;
@property (nonatomic, assign) ZXCycleViewDirection direction; // Default is ZXCycleViewDirectionHorizontal
@property (nonatomic, assign) NSInteger currentPage; // Default 0
@property (nonatomic, assign) NSInteger numberOfPages; // Default 0
@property (nonatomic, assign) NSTimeInterval timeInterval; // Default 0, no auto paging, least 0.1 sec.

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated;

@end
