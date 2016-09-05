//
//  ZXBadgeLabel.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "ZXBadgeLabel.h"

@implementation ZXBadgeLabel

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.audoHide = YES;
        self.number = 0;
        self.threshold = 99;
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.audoHide = YES;
        self.number = 0;
        self.threshold = 99;
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //
    if (self.layer.masksToBounds || self.clipsToBounds) {
        self.layer.cornerRadius = self.frame.size.height / 2;
    }
    //
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    size.width += self.frame.size.height / 2;
    size.height = self.frame.size.height;
    if (size.width < size.height) {
        size.width = size.height;
    }
    // AutoLayout
    if (self.constraints.count > 0) {
        [self removeConstraints:self.constraints];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:size.width]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:size.height]];
    } else {
        CGRect rect = self.frame;
        rect.origin = self.center;
        rect.size = size;
        self.frame = rect;
        self.center = rect.origin;
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setNumber:(NSUInteger)number {
    _number = number;
    //
    if (self.audoHide) {
        self.hidden = _number == 0;
    }
    //
    [self updateText];
}

- (void)setThreshold:(NSUInteger)threshold {
    _threshold = threshold;
    [self updateText];
}

- (void)updateText {
    //
    if (_number > _threshold) {
        self.text = [NSString stringWithFormat:@"%d+", (int)_threshold];
    } else if (_number > 0) {
        self.text = [NSString stringWithFormat:@"%d", (int)_number];
    }
    // Fix bugs for UILabel on iOS 8.x
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        [self layoutSubviews];
    } else {
        [self setNeedsLayout];
    }
}

@end
