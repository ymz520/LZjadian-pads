//
//  AdjustImageView.h
//  volude_demo
//
//  Created by Mac on 16/4/18.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdjustModel;
@interface AdjustImageView : UIImageView

@property(nonatomic,strong)AdjustModel *model;
-(void)sliderValueChanged:(UISlider *)slider;
@end
