//
//  sconedSliderTableViewCell.m
//  IOS_LZhomeAppliances
//
//  Created by biti on 16/7/11.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "sconedSliderTableViewCell.h"

@implementation sconedSliderTableViewCell

- (void)awakeFromNib {
    [self setSliderStyleandslider:_sliderOne];
    [self setSliderStyleandslider:_sliderTwo];
    [self setSliderStyleandslider:_sliderThere];
    [self.sliderTwo setMaximumValue:255.0];
    [self.sliderTwo setMinimumValue:0];
    int num=arc4random()%255+0;
    NSLog(@"%d",num);
//    [self.sliderTwo setMinimumTrackTintColor:[UIColor colorWithRed:num green:num blue:num alpha:1]];
    
}

-(void)setSliderStyleandslider:(UISlider *)slider
{
    
    [slider setMinimumTrackImage:[UIImage imageNamed:@"滑动条-2"] forState:UIControlStateNormal];
    [slider setMaximumTrackImage:[UIImage imageNamed:@"滑动条-1"] forState:UIControlStateNormal];
    [slider setThumbImage:[UIImage imageNamed:@"滑动按钮"] forState:UIControlStateNormal];


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}

- (IBAction)oneSliderAction:(UISlider *)sender
{
    
}

- (IBAction)SliderAction:(UISlider *)sender
{
//    UIColor *colors
//    int num=arc4random()%255+0;
//    NSLog(@"%d",num);
    [self.sliderTwo setMinimumTrackTintColor:[UIColor colorWithRed:arc4random()%255+0 green:arc4random()%255+0 blue:arc4random()%255+0 alpha:1]];
    [_sliderThere setMinimumTrackTintColor:[UIColor colorWithRed:sender.value green:sender.value blue:0 alpha:1]];
}

- (IBAction)thereSliderAction:(UISlider *)sender
{
    _sliderThere.value=sender.value;
}
@end
