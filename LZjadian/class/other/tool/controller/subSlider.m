//
//  subSlider.m
//  LZjadian
//
//  Created by 张 荣桂 on 16/4/20.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "subSlider.h"

@implementation subSlider
#pragma mark-拇指的矩形边界
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
//    y轴方向改变手势范围
    rect.origin.y = rect.origin.y-10 ;
    rect.size.height = rect.size.height+20 ;
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:0], 10 ,10);
}

@end
