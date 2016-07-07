//
//  myCollectionViewCell.m
//  mycollectionviewexample
//
//  Created by 张 荣桂 on 16/6/14.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "myCollectionViewCell.h"
@interface myCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgv;
@end
@implementation myCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.imgv.layer.borderWidth=3;
    self.imgv.layer.borderColor=[UIColor whiteColor].CGColor;
    self.imgv.layer.cornerRadius=5;
    self.imgv.clipsToBounds=YES;
}
-(void)setImgstr:(NSString *)imgstr
{
    _imgstr=[imgstr copy];
    self.imgv.image=[UIImage imageNamed:_imgstr];

}
@end
