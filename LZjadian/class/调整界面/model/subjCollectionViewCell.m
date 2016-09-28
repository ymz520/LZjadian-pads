//
//  subjCollectionViewCell.m
//  IOS_LZhomeAppliances
//
//  Created by 张 荣桂 on 16/7/14.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "subjCollectionViewCell.h"

@implementation subjCollectionViewCell

- (void)awakeFromNib {
    self.subImgv.layer.cornerRadius=20;
    self.subImgv.clipsToBounds=YES;
    self.subImgv.backgroundColor=[UIColor grayColor];
}

-(void)setImgst:(NSString *)imgstr
{
    _imgstr=[imgstr copy];
    [self.subImgv setImage:[UIImage imageNamed:_imgstr] forState:UIControlStateNormal];
//    self.subImgv.image=[UIImage imageNamed:_imgstr];
    
}
@end
