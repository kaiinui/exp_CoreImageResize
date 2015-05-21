//
//  FLMCoreImageResizer.m
//  CIResize
//
//  Created by kaiinui on 2015/05/21.
//  Copyright (c) 2015年 kaiinui. All rights reserved.
//

#import "FLMCoreImageResizer.h"
#import <ImageIO/ImageIO.h>
#import "FLMCIContextHolder.h"

NSString *const kFLMCoreImageResizerCILanczosScaleTransformName = @"CILanczosScaleTransform";
NSString *const kFLMCoreImageResizerCILanczosScaleTransformInputImageKey = @"inputImage"; // @type CIImage
NSString *const kFLMCoreImageResizerCILanczosScaleTransformInputScaleKey = @"inputScale"; // @type NSNumber<CGFloat>

@implementation FLMCoreImageResizer

+ (NSData *)resizedImageDataFromCIImage:(CIImage *)image orientation:(UIImageOrientation)orientation UTI:(NSString *)UTI scale:(CGFloat)scale compressionQuality:(CGFloat)quality {
    int cgImagePropertyOrientationValue = [self cgImagePropertyOrientationFromUIImageOrientation:orientation];
    
    CIImage *orientatedImage = [image imageByApplyingOrientation:cgImagePropertyOrientationValue];
    CIImage *resizedImage = [self resizedImageFromCIImage:orientatedImage scale:scale];
    NSData *imageData = [self jpgDataFromCIImage:resizedImage quality:quality UTI:UTI];
    
    return imageData;
}

+ (NSData *)jpgDataFromCIImage:(CIImage *)image quality:(CGFloat)quality UTI:(NSString *)UTI{
    @autoreleasepool {
        CIContext *context = [FLMCIContextHolder sharedHolder].context;
        
        CGImageRef resultImage = [context createCGImage:image fromRect:image.extent];
        NSMutableData *resultData = [NSMutableData data];
        
        CGImageDestinationRef destination = CGImageDestinationCreateWithData((CFMutableDataRef)resultData, (CFStringRef)UTI, 1, nil);
        
        NSString *lossyCompressionQualityKey = (NSString *)kCGImageDestinationLossyCompressionQuality;
        CFDictionaryRef params = (CFDictionaryRef)CFBridgingRetain(@{
                                                                     lossyCompressionQualityKey: @(quality)
                                                                     });
        CGImageDestinationAddImage(destination, resultImage, params);
        CGImageDestinationFinalize(destination);
        
        CFRelease(destination);
        CFRelease(params);
        CGImageRelease(resultImage);
        
        return resultData;
    }
}

+ (CIImage *)resizedImageFromCIImage:(CIImage *)image scale:(CGFloat)scale {
    NSDictionary *params = @{
                             kFLMCoreImageResizerCILanczosScaleTransformInputImageKey: image,
                             kFLMCoreImageResizerCILanczosScaleTransformInputScaleKey: @(scale)
                             };
    
    CIFilter *filter = [CIFilter filterWithName:kFLMCoreImageResizerCILanczosScaleTransformName withInputParameters:params];
    
    return [filter outputImage];
}

+ (int)cgImagePropertyOrientationFromUIImageOrientation:(UIImageOrientation)orientation {
    // @see http://stackoverflow.com/questions/6699330/how-to-save-photo-with-exifgps-and-orientation-on-iphone
    // kCGImagePropertyOrientation
    /*
     
     UIImageOrientationUp:             1
     UIImageOrientationDown:           3
     UIImageOrientationLeft:           8
     UIImageOrientationRight:          6
     UIImageOrientationUpMirrored:     2
     UIImageOrientationDownMirrored:   4
     UIImageOrientationLeftMirrored:   5
     UIImageOrientationRightMirrored:  7
     
     */
    switch (orientation) {
        case UIImageOrientationUp:
            return 1;
        case UIImageOrientationDown:
            return 3;
        case UIImageOrientationLeft:
            return 8;
        case UIImageOrientationRight:
            return 6;
        case UIImageOrientationUpMirrored:
            return 2;
        case UIImageOrientationDownMirrored:
            return 4;
        case UIImageOrientationLeftMirrored:
            return 5;
        case UIImageOrientationRightMirrored:
            return 7;
            
    }
}

@end
