//
//  QRCodeGenerator.m
//  CodeLibary
//
//  Created by wlh on 16/9/2.
//  Copyright © 2016年 linxun. All rights reserved.
//

#import "QRCodeGenerator.h"

#define QRCodeDefaultColor [UIColor blackColor]

@implementation QRCodeGenerator

CIImage* CIImageWithData(NSData *data)
{
    // 创建 Filter
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回 CIImage
    return filter.outputImage;
}

UIImage* UIImageFormCIImage(CIImage *image, CGFloat size)
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextScaleCTM(contextRef, scale, scale);
    CGContextDrawImage(contextRef, extent, imageRef);
    CGImageRelease(imageRef);
    //
    imageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    //
    return result;
}

void CGDataProviderReleaseData(void *info, const void *data, size_t size)
{
    free((void *)data);
}

UIImage* UIImageWithColor(UIImage *image, UIColor *color) {
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *imageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(imageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    //
    CGFloat red = 0, green = 0, blue = 0, alpha = 0;
    {
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
        red *= 255;
        green *= 255;
        blue *= 255;
    }
    // 遍历像素
    uint32_t *pixel = imageBuf;
    int pixels = imageWidth * imageHeight;
    for (int i = 0; i < pixels; i++, pixel++) {
        if ((*pixel & 0xFFFFFF00) < 0x99999900) {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t *ptr = (uint8_t *)pixel;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        } else {
            // 将底色变成透明
            uint8_t *ptr = (uint8_t *)pixel;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProviderRef = CGDataProviderCreateWithData(NULL, imageBuf, bytesPerRow * imageHeight, CGDataProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProviderRef,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProviderRef);
    //
    UIImage *result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    //
    return result;
}

+ (UIImage *)imageWithData:(NSData *)data size:(CGFloat)size {
    return [QRCodeGenerator imageWithData:data size:size color:nil];
}

+ (UIImage *)imageWithData:(NSData *)data size:(CGFloat)size color:(UIColor *)color {
    CIImage *codeImage = CIImageWithData(data);
    UIImage *grayImage = UIImageFormCIImage(codeImage, size);
    return UIImageWithColor(grayImage, color ? color : QRCodeDefaultColor);
}

+ (UIImage *)imageWithString:(NSString *)string size:(CGFloat)size {
    return [QRCodeGenerator imageWithString:string size:size color:nil];
}

+ (UIImage *)imageWithString:(NSString *)string size:(CGFloat)size color:(UIColor *)color {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [QRCodeGenerator imageWithData:data size:size color:color];
}

@end
