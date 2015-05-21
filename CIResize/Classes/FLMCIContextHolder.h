//
//  FLMCIContextHolder.h
//  CIResize
//
//  Created by kaiinui on 2015/05/21.
//  Copyright (c) 2015年 kaiinui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

@interface FLMCIContextHolder : NSObject

+ (instancetype)sharedHolder;

@property (atomic, strong) CIContext *context;

@end
