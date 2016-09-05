//
//  ZXTabBarController.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ZXTabBarController : UITabBarController
@property (nonatomic, assign) IBInspectable BOOL originalItemImage; // Always draw the original image of item
@property (nonatomic, strong) IBInspectable UIColor *selectedItemColor;

@end

IB_DESIGNABLE
@interface ZXTabBarItemController : UIViewController
@property (nonatomic, strong) IBInspectable NSString *storyboardID;
@property (nonatomic, strong) IBInspectable NSString *storyboardName;

@end

