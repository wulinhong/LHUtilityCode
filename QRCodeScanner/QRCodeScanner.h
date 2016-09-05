//
//  QRCodeScanner.h
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

typedef void(^QRCodeScannerOutput)(NSArray<NSString *> *results);

@interface QRCodeScanner : NSObject
@property (nonatomic, readonly) BOOL isScanning;

- (instancetype)initWithPreview:(UIView *)preview captureRect:(CGRect)frame;

- (void)startScanning:(QRCodeScannerOutput)output;
- (void)stopScanning;

@end
