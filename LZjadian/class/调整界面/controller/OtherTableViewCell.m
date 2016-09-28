//
//  OtherTableViewCell.m
//  IOS_LZhomeAppliances
//
//  Created by 张 荣桂 on 16/7/12.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "OtherTableViewCell.h"

@implementation OtherTableViewCell

- (void)awakeFromNib {
    _segment.layer.cornerRadius=5;
    _segment.clipsToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
