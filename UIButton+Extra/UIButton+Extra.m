//
//  UIButton.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "UIButton+Extra.h"

@implementation UIButton (Extra)

- (void)setForceRightToLeft:(CGFloat)spacing forState:(UIControlState)state {
    if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0) {
        NSString *title = [self titleForState:state];
        UIImage *image = [self imageForState:state];
        if (title && image) {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width - spacing / 2, 0, image.size.width)];
            CGSize labelSize = [title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, labelSize.width, 0, -labelSize.width - spacing / 2)];
        }
    } else {
        self.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -spacing / 2, 0, 0)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -spacing / 2)];
    }
}

@end
