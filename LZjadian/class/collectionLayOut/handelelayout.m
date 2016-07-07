//
//  handelelayout.m
//  mycollectionviewexample
//
//  Created by 张 荣桂 on 16/7/3.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "handelelayout.h"
static const CGFloat layoutitemwh=100;
@implementation handelelayout
-(instancetype)init
{
    if (self=[super init]) {
        
        
        
    }
    return self;
    
}
#pragma mark-准备布局
-(void)prepareLayout
{
    [super prepareLayout];
    //cell的大小
    self.itemSize=CGSizeMake(layoutitemwh, layoutitemwh);
    //滚动方向横行滚动
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    //布局属性ui每一个（item）cell都有自己的
    //每一个（item）cell间距
    self.minimumLineSpacing=100;
    //
    CGFloat inset=(self.collectionView.frame.size.width-layoutitemwh)/2;
    
    self.sectionInset=UIEdgeInsetsMake(0, inset, 0, inset);

}
#pragma mark-s当显示的边界发生改变就重新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;

}
#pragma mark-
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //collectionview的rect
    //1.取出默认的cell的layoutAttribute
    NSLog(@"++++++++");
    NSArray *ars=[super layoutAttributesForElementsInRect:rect];
    NSLog(@"%.f",self.collectionView.contentOffset.x);
    //计算屏幕中间的x
    CGFloat centerX=self.collectionView.contentOffset.x+self.collectionView.center.x;
    //2.
    for (UICollectionViewLayoutAttributes *layoutAttr in ars)
    {
        //每一个item的中心坐标
        CGFloat itemcenterx=layoutAttr.center.x;
        //跟屏幕中间距离绝对值
        CGFloat jianju=ABS(centerX-itemcenterx);
//        layoutAttr.
        //scale缩放
        layoutAttr.transform3D=CATransform3DMakeScale(1.5, 1.5, 1.0);
        
    }
    
    return ars;
    

}
@end
