//
//  sconedSliderTableViewCell.h
//  IOS_LZhomeAppliances
//
//  Created by biti on 16/7/11.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sconedSliderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *smallImgvOne;
@property (weak, nonatomic) IBOutlet UISlider *sliderOne;
@property (weak, nonatomic) IBOutlet UIImageView *bigImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *smallImgvTwo;
@property (weak, nonatomic) IBOutlet UISlider *sliderTwo;
@property (weak, nonatomic) IBOutlet UIImageView *bigImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *bttomImgv;
@property (weak, nonatomic) IBOutlet UIImageView *smallImgvThere;
@property (weak, nonatomic) IBOutlet UISlider *sliderThere;
@property (weak, nonatomic) IBOutlet UIImageView *bigImgThere;
- (IBAction)oneSliderAction:(UISlider *)sender;
- (IBAction)SliderAction:(UISlider *)sender;
- (IBAction)thereSliderAction:(UISlider *)sender;


@end
