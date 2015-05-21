//
//  FLMCoreImageResizer.h
//  CIResize
//
//  Created by kaiinui on 2015/05/21.
//  Copyright (c) 2015年 kaiinui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

@interface FLMCoreImageResizer : NSObject

+ (NSData *)resizedImageDataFromCIImage:(CIImage *)image orientation:(UIImageOrientation)orientation UTI:(NSString *)UTI scale:(CGFloat)scale compressionQuality:(CGFloat)quality;

@end
