//
//  AdjustModel.m
//  volude_demo
//
//  Created by Mac on 16/4/18.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "AdjustModel.h"

@implementation AdjustModel

+ (instancetype)modelWithThumnImage:(NSString *)thumbImage stetchLeftTrack:(NSString *)stetchLeftTrack icostetchRightTrackn:(NSString *)icostetchRightTrackn lowerImg:(NSString *)lowerImg{
    return [[self alloc] initWithThumnImage:thumbImage stetchLeftTrack:stetchLeftTrack icostetchRightTrackn:icostetchRightTrackn lowerImg:lowerImg];
}


- (instancetype)initWithThumnImage:(NSString *)thumbImage stetchLeftTrack:(NSString *)stetchLeftTrack icostetchRightTrackn:(NSString *)icostetchRightTrackn lowerImg:(NSString *)lowerImg{
    if (self = [super init]) {
        self.thumbImage = thumbImage;
        self.stetchLeftTrack = stetchLeftTrack;
        self.icostetchRightTrackn = icostetchRightTrackn;
        self.lowerImg = lowerImg;
    }
    return self;
}
@end
