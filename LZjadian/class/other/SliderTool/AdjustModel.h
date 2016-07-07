//
//  AdjustModel.h
//  volude_demo
//
//  Created by Mac on 16/4/18.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdjustModel : NSObject

/**
 *  滑块图片
 */
@property (nonatomic, copy) NSString *thumbImage;
/**
 *  左轨图片
 */
@property (nonatomic, copy) NSString *stetchLeftTrack;
/**
 *  右轨图片
 */
@property (nonatomic, copy) NSString *icostetchRightTrackn;
/**
 *  滑块底部图片
 */
@property (nonatomic, copy) NSString *lowerImg;


+ (instancetype)modelWithThumnImage:(NSString *)thumbImage stetchLeftTrack:(NSString *)stetchLeftTrack icostetchRightTrackn:(NSString *)icostetchRightTrackn lowerImg:(NSString *)lowerImg;
- (instancetype)initWithThumnImage:(NSString *)thumbImage stetchLeftTrack:(NSString *)stetchLeftTrack icostetchRightTrackn:(NSString *)icostetchRightTrackn lowerImg:(NSString *)lowerImg;
@end
