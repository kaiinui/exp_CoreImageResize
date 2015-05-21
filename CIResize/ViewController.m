//
//  ViewController.m
//  CIResize
//
//  Created by kaiinui on 2015/05/21.
//  Copyright (c) 2015年 kaiinui. All rights reserved.
//

#import "ViewController.h"
#import "FLMCoreImageResizer.h"

@import Photos;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PHAsset *asset = [PHAsset fetchAssetsWithOptions:nil].firstObject;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    NSDate *startDate = [NSDate date];
    for (int i = 0; i < 50; i++) {
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(500, 750) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage *result, NSDictionary *info) {
            @autoreleasepool {
                NSData *data = UIImageJPEGRepresentation(result, 0.9);
                
                NSLog(@"%ld", (long)data.length);
            }
        }];
    }
    NSLog(@"%lf", [[NSDate date] timeIntervalSinceDate:startDate]);
    
    NSDate *start2 = [NSDate date];
    for (int i = 0; i < 50; i++) {
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
            @autoreleasepool {
                
                CIImage *image = [CIImage imageWithData:imageData];
                NSData *data = [FLMCoreImageResizer resizedImageDataFromCIImage:image orientation:orientation UTI:dataUTI scale:0.5 compressionQuality:0.9];
                
                NSLog(@"Resized DataSize: %ld", (long)data.length);
            }
        }];
    }
    NSLog(@"%lf", [[NSDate date] timeIntervalSinceDate:start2]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
