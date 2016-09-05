//
//  UIPopoverWindow.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "UIPopoverWindow.h"

#define UIPopoverWindowPresentColor [[UIColor blackColor] colorWithAlphaComponent:.4]
#define UIPopoverWindowPresentDuration .3

#define UIPopoverWindowDismissColor [UIColor clearColor]
#define UIPopoverWindowDismissDuration .2

@interface UIPopoverWindow () <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIView *weakView;

@end

@implementation UIPopoverWindow

- (UIView *)popoverView {
    return self.weakView;
}

- (void)presentView:(UIView *)view {
    self.weakView = view;
    if (_weakView) {
        CGRect frame = self.frame;
        frame.origin.y = self.frame.size.height;
        frame.size.height = _weakView.frame.size.height;
        _weakView.frame = frame;
        [self addSubview:_weakView];
    }
    self.backgroundColor = UIPopoverWindowDismissColor;
    self.hidden = NO;
    //
    __weak typeof(self) weakSelf = self;
    CGRect frame = _weakView.frame;
    frame.origin.y = self.frame.size.height - _weakView.frame.size.height;
    [UIView animateWithDuration:UIPopoverWindowPresentDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.backgroundColor = UIPopoverWindowPresentColor;
        _weakView.frame = frame;
    } completion:^(BOOL finished) {
        weakSelf.backgroundColor = UIPopoverWindowPresentColor;
        _weakView.frame = frame;
        //
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(dismiss)];
        tap.delegate = self;
        [weakSelf addGestureRecognizer:tap];
    }];
}

- (void)dismiss {
    __weak typeof(self) weakSelf = self;
    CGRect frame = _weakView.frame;
    frame.origin.y = self.frame.size.height;
    [UIView animateWithDuration:UIPopoverWindowDismissDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _weakView.frame = frame;
        weakSelf.backgroundColor = UIPopoverWindowDismissColor;
    } completion:^(BOOL finished) {
        [_weakView removeFromSuperview];
        weakSelf.hidden = YES;
    }];
}

#pragma mark <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.weakView];
    return !CGRectContainsPoint(self.weakView.bounds, point);
}

@end
