//
//  OtherTableViewCell.h
//  IOS_LZhomeAppliances
//
//  Created by 张 荣桂 on 16/7/12.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *leftImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgTwo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end
