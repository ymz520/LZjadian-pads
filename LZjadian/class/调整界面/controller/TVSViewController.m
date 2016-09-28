//
//  TVSViewController.m
//  LZjadian
//
//  Created by 张 荣桂 on 16/4/5.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "TVSViewController.h"
#import "Masonry.h"
#import "myFlow.h"
#import "subjCollectionViewCell.h"
@interface TVSViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIButton *backbtn;
    NSMutableArray *_imgOne;
    NSMutableArray *_imgTwo;
    NSMutableArray *_imgThere;
    NSMutableArray *_imgFour;
    UICollectionView *collectionv;
    
    
}
@end
static NSString *cellstr=@"cell";
@implementation TVSViewController
//懒加载
-(NSArray *)sectionCount
{
    if (!_sectionCount)
    {
        
        _imgOne=[NSMutableArray array];
        _imgTwo=[NSMutableArray array];
        _imgFour=[NSMutableArray array];
        _imgThere=[NSMutableArray array];
        for (int i=1; i<11; i++)
        {
            [_imgOne addObject:[NSString stringWithFormat:@"1-%d",i]];
//            [self.sectionCount addObject:@"1-1.1"];
        }
        for (int i=11; i<24; i++) {
            [_imgTwo addObject:[NSString stringWithFormat:@"1-%d",i]];
        }
             for (int i=24; i<39; i++) {
            [_imgThere addObject:[NSString stringWithFormat:@"1-%d",i]];
        }

                  for (int i=39; i<44; i++) {
                 [_imgFour addObject:[NSString stringWithFormat:@"1-%d",i]];
             }
       self.sectionCount=[NSArray arrayWithObjects:_imgOne,_imgTwo,_imgThere,_imgFour, nil];

        
    }
    return _sectionCount;


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *vi=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
    vi.image=[UIImage imageNamed:@"1-1-0.png"];
//    [self.view addSubview:vi];
    [self createCollectionV];
//    [self createtv];
}
#pragma mark-创建uicollectionview
-(void)createCollectionV
{
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    collectionv=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    collectionv.backgroundColor=[UIColor grayColor];
    [collectionv registerNib:[UINib nibWithNibName:@"subjCollectionViewCell"bundle:nil] forCellWithReuseIdentifier:cellstr];
    collectionv.delegate=self;
    collectionv.dataSource=self;
    
//    layout.delegateFlowLayout=self;
   layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing=0.0;
//    layout.m=5.0;
    [self.view addSubview:collectionv];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
     NSLog(@"%lu",[self.sectionCount count]);
    return [self.sectionCount count];

}
#pragma mark-datasoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%lu",(unsigned long)[[_sectionCount objectAtIndex:section]count]);
    return [[_sectionCount objectAtIndex:section]count];
    

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    subjCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellstr forIndexPath:indexPath];
    NSLog(@"%@",[_sectionCount[indexPath.section] objectAtIndex:indexPath.row]);
//    cell.imgstr=;
    [cell.subImgv setBackgroundImage:[UIImage imageNamed:[_sectionCount[indexPath.section] objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    [cell.subImgv addTarget:self action:@selector(bottonOnclick:) forControlEvents:UIControlEventTouchUpInside];
//    cell.subImgv.image=[UIImage imageNamed:@"1-1.1"];
    return cell;

}
#pragma mark-按钮点击事件
-(void)bottonOnclick:(UIButton *)sender
{
    //cell--->contentview－－－－>button
    UIView *v=[sender superview];//获取父类（contentview）
    subjCollectionViewCell *cell=(subjCollectionViewCell *)[v superview];//获取（contentview）的父类
    NSIndexPath *indexpaths=[collectionv indexPathForCell:cell];//获取cell对应的indexpath
    NSLog(@"==%@",[NSString stringWithFormat:@"%@.1",[_sectionCount[indexpaths.section] objectAtIndex:indexpaths.row]]);
    if (!sender.selected)
    {
        [sender setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-0",[_sectionCount[indexpaths.section] objectAtIndex:indexpaths.row]]] forState:UIControlStateSelected];
        
    }else
    {
        [sender setBackgroundImage:[UIImage imageNamed:[_sectionCount[indexpaths.section] objectAtIndex:indexpaths.row]] forState:UIControlStateNormal];
    }
    sender.selected=!sender.selected;
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insetForSection;
    if (section>1)
    {
        insetForSection = UIEdgeInsetsMake(0, 100, 0, 100);
    }
    insetForSection = UIEdgeInsetsMake(15, 100, 15, 100);
    return insetForSection;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>0&indexPath.section<3)
    {
        
        
        if (indexPath.section==1)
        {
            NSLog(@"%ld===%ld",(long)indexPath.section, (long)indexPath.item);
            if (indexPath.item==5||indexPath.item==9)
            {
                return CGSizeMake(100, 160);
            }
        }
        
        
        return CGSizeMake(100, 100);
        
    }else
    {
        return CGSizeMake(100, 80);
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
