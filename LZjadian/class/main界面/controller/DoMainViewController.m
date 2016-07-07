//
//  DoMainViewController.m
//  IOS_LZhomeAppliances
//
//  Created by biti on 16/7/6.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "DoMainViewController.h"
#import "myCollectionViewCell.h"
#import "handelelayout.h"
@interface DoMainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end
static NSString * const cellstr=@"mycell";
@implementation DoMainViewController
//懒加载
-(NSMutableArray *)imgar
{
    
    if (!_imgar)
    {
        self.imgar=[[NSMutableArray alloc]init];
        [self.imgar addObjectsFromArray:@[@"客厅",@"餐厅",@"餐厅",@"餐厅",@"餐厅",@"餐厅",@"餐厅",@"餐厅",@"餐厅"]];
//        for (int i=1; i<=13; i++) {
//            [self.imgar addObject:[NSString stringWithFormat:@"%d",i]];
//        }
        
    }
    return _imgar;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionView *collectionV=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    [collectionV registerNib:[UINib nibWithNibName:@"myCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellstr];
    //    [collectionV registerClass:[myCollectionViewCell class] forCellWithReuseIdentifier:cellstr];
    collectionV.backgroundColor=[UIColor blackColor];
    collectionV.delegate=self;
    collectionV.dataSource=self;
    //    collectionV.backgroundColor=[UIColor]
    [self.view addSubview:collectionV];
}
#pragma mark-datasoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgar.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    myCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellstr forIndexPath:indexPath];
    cell.imgstr=[_imgar objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor redColor];
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
