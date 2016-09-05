//
//  HMWebViewController.h
//  HuiMai
//
//  Created by wlh on 16/6/27.
//  Copyright © 2016年 Linxun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMWebViewController : UIViewController

@property (nonatomic, strong) UIWebView *webView;
// 传递要加载的URL
- (void)loadHTML:(NSString *)htmlString;
@end
