//
//  UITableViewCell+Separator.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "UITableViewCell+Separator.h"

@implementation UITableViewCell (Separator)

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //
    if (self.separatorInset.top > 0.f) {
        CGPoint points[2];
        points[0] = CGPointMake(self.separatorInset.left, 0);
        points[1] = CGPointMake(self.frame.size.width - self.separatorInset.right, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, self.separatorInset.top);
        CGContextSetStrokeColorWithColor(context, self.separatorColor.CGColor);
        CGContextAddLines(context, points, 2);
        CGContextDrawPath(context, kCGPathStroke);
    }
    //
    if (self.separatorInset.bottom > 0.f) {
        CGPoint points[2];
        points[0] = CGPointMake(self.separatorInset.left, self.frame.size.height);
        points[1] = CGPointMake(self.frame.size.width - self.separatorInset.right, self.frame.size.height);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, self.separatorInset.bottom);
        CGContextSetStrokeColorWithColor(context, self.separatorColor.CGColor);
        CGContextAddLines(context, points, 2);
        CGContextDrawPath(context, kCGPathStroke);
    }
}

#pragma mark Getter & Setter

- (void)saveSeparatorColor:(UIColor *)separatorColor {
    objc_setAssociatedObject(self, @selector(separatorColor), separatorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)separatorColor {
    UIColor *color = objc_getAssociatedObject(self, @selector(separatorColor));
    if (color == nil) {
        color = [[UITableView alloc] init].separatorColor;
        self.separatorColor = color;
    }
    return color;
}

- (void)setSeparatorInset:(UIEdgeInsets)separatorInset {
    NSString *str = NSStringFromUIEdgeInsets(separatorInset);
    objc_setAssociatedObject(self, @selector(separatorInset), str, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)separatorInset {
    UIEdgeInsets inset = UIEdgeInsetsZero;
    NSString *str = objc_getAssociatedObject(self, @selector(separatorInset));
    if (str == nil) {
        inset = [[UITableView alloc] init].separatorInset;
        self.separatorInset = inset;
    } else {
        inset = UIEdgeInsetsFromString(str);
    }
    return inset;
}

@end
