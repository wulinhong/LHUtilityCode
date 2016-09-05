//
//  QRCodeScanner.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "QRCodeScanner.h"

@interface QRCodeScanner () <AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, copy)   QRCodeScannerOutput outputBlock;

@end

@implementation QRCodeScanner

- (instancetype)initWithPreview:(UIView *)preview captureRect:(CGRect)frame {
    self = [super init];
    if (self) {
        _session = [[AVCaptureSession alloc] init];
        _session.sessionPreset = AVCaptureSessionPresetHigh;
        //
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
        [_session addInput:_input];
        //
        _output = [[AVCaptureMetadataOutput alloc] init];
        [_session addOutput:_output];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [_output setMetadataObjectTypes:_output.availableMetadataObjectTypes];
        //
        if (preview) {
            _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
            _preview.frame = preview.layer.bounds;
            [preview.layer insertSublayer:_preview atIndex:0];
            // top-left to top-right coordinate system (Rotate 90° CCW), the origin is the central point
            _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
            CGRect rect = CGRectMake(((preview.frame.size.height - frame.size.height) / 2) / preview.frame.size.height,
                                     ((preview.frame.size.width - frame.size.width) / 2) / preview.frame.size.width,
                                     frame.size.height / _preview.frame.size.height,
                                     frame.size.width / _preview.frame.size.width);
            _output.rectOfInterest = rect;
        }
    }
    return self;
}

- (BOOL)isScanning {
    return _session.isRunning;
}

- (void)startScanning:(QRCodeScannerOutput)output {
    self.outputBlock = output;
    [_session startRunning];
}

- (void)stopScanning {
    [_session stopRunning];
}

#pragma mark <AVCaptureMetadataOutputObjectsDelegate>

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    //
    NSMutableArray<NSString *> *results = [NSMutableArray array];
    for (AVMetadataMachineReadableCodeObject *object in metadataObjects) {
        if (object.stringValue) {
            [results addObject:object.stringValue];
        }
    }
    //
    if (_outputBlock && results.count > 0) {
        _outputBlock(results);
    }
}

@end
