//
//  myFlow.m
//  IOS_LZhomeAppliances
//
//  Created by 张 荣桂 on 16/7/14.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "myFlow.h"
static const CGFloat itemW=100;
static const CGFloat itemH=50;
@implementation myFlow
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
//    NSArray *ars=[super layoutAttributesForElementsInRect:rect];
   
    NSMutableArray *ars=[NSMutableArray array];
    for (int j=0; j<4; j++)
    {
        
   
    for (int i=0; i<[self.collectionView numberOfItemsInSection:j]; i++)
    {
        UICollectionViewLayoutAttributes *attr=[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:j]];
        if (j==1 ||j==2)
        {
            if (i==5||i==9)
            {
                attr.size=CGSizeMake(150, 300);
            }
            attr.size=CGSizeMake(150, 150);
        }else
        {
            attr.size=CGSizeMake(itemW, itemH);

        
        }
        
        [ars addObject:attr];
        
    }
  }
    return ars;
    
    
    
}
@end
