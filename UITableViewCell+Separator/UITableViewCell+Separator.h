//
//  UITableViewCell+Separator.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UITableViewCell (Separator)

// Default is the standard separator gray, private property in UITableViewCell.
@property (nonatomic, strong, setter=saveSeparatorColor:) UIColor *separatorColor;

// Draw the separator if top/bottom great than 0, and specified line width.
@property (nonatomic, assign) UIEdgeInsets separatorInset;

@end
