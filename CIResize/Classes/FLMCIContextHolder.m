//
//  FLMCIContextHolder.m
//  CIResize
//
//  Created by kaiinui on 2015/05/21.
//  Copyright (c) 2015年 kaiinui. All rights reserved.
//

#import "FLMCIContextHolder.h"

@implementation FLMCIContextHolder

+ (instancetype)sharedHolder {
    static FLMCIContextHolder *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[FLMCIContextHolder alloc] init];
        _instance.context = [CIContext contextWithOptions:@{}];
    });
    return _instance;
}

@end
