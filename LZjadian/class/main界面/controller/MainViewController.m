//
//  ViewController.m
//  LZjadian
//
//  Created by 张 荣桂 on 16/3/15.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "MainViewController.h"
#import "MBProgressHUD+MJ.h"
#import "updateViewController.h"
#import "RoomequipmentViewController.h"
@interface MainViewController ()<passingValueDelegate>
{
    NSMutableArray *_homeAequipmentars;
   
    NSString *_documents;
    NSArray *_homears;
    NSString *_equipmentars;
    NSMutableArray *_readerHomeArs;
    NSMutableArray *_readerEquipmentArs;
     NSMutableArray *_readerHomecodeArs;
    NSMutableDictionary  *_homedicts;
    NSMutableArray  *_equipmentapps;
    NSArray *_eqars;
    NSString *_nameds;
    int _updateNameId;

}
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    self.navigationController.navigationBar.barTintColor=[UIColor grayColor];
    //权限按钮
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(setviewinfo) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    _homedicts = [NSMutableDictionary dictionary];
    _equipmentapps=[[NSMutableArray alloc]initWithCapacity:0];
    _eqars=@[@{@"客厅":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"空调",@"地暖",@"音乐",@"窗帘",@"饮水",@"插座",@"情景模式",@"离家模式",nil]},@{@"餐厅":[[NSArray alloc]initWithObjects:@"灯光",@"燃气",@"自来水",@"电器",@"插座",nil]},@{@"厨房":[[NSArray alloc]initWithObjects:@"灯光",@"燃气",@"自来水",@"电器",@"插座",nil]},@{@"主卧室":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"空调",@"地暖",@"音乐",@"窗帘",@"插座",@"情景模式",@"电动床",nil]},@{@"女儿房":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"空调",@"地暖",@"音乐",@"窗帘",@"插座",@"情景模式",@"电动床",nil]},@{@"儿子房":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"空调",@"地暖",@"音乐",@"窗帘",@"插座",@"情景模式",@"电动床",nil]},@{@"老人房":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"空调",@"地暖",@"音乐",@"窗帘",@"插座",@"情景模式",@"电动床",nil]},@{@"书房":[[NSArray alloc]initWithObjects:@"灯光",@"音乐",@"空调",@"地暖",@"窗帘",@"插座",nil]},@{@"主卫生间":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"换气",@"浴霸",@"洗衣机",@"窗帘",@"插座",nil]},@{@"次卫生间":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"换气",@"浴霸",@"洗衣机",@"窗帘",@"插座",nil]},@{@"南阳台":[[NSArray alloc]initWithObjects:@"灯光",@"洗衣机",@"衣架",@"插座",nil]},@{@"北阳台":[[NSArray alloc]initWithObjects:@"灯光",@"洗衣机",@"衣架",@"插座",nil]},];
    [_equipmentapps addObjectsFromArray:_eqars];
    
    [_homedicts setObject:_equipmentapps[0] forKey:@"A"];
    [_homedicts setObject:_equipmentapps[1] forKey:@"B"];
    [_homedicts setObject:_equipmentapps[2] forKey:@"C"];
    [_homedicts setObject:_equipmentapps[3] forKey:@"D"];
    [_homedicts setObject:_equipmentapps[4] forKey:@"E"];
    [_homedicts setObject:_equipmentapps[5] forKey:@"F"];
    [_homedicts setObject:_equipmentapps[6] forKey:@"G"];
    [_homedicts setObject:_equipmentapps[7] forKey:@"H"];
    [_homedicts setObject:_equipmentapps[8] forKey:@"W"];
    [_homedicts setObject:_equipmentapps[9] forKey:@"J"];
    [_homedicts setObject:_equipmentapps[10] forKey:@"K"];
    [_homedicts setObject:_equipmentapps[11] forKey:@"Y"];
    //存数据
    [self saveData:_homedicts];
  
    
   
}
#pragma mark-九宫格布局
-(void)createJIU:(NSMutableArray *)homears ande:(NSMutableArray *)ars
{
    for(id tmpView in self.view.subviews)
    {
        //找到要删除的子视图的对象
        if([tmpView isKindOfClass:[UIView class]])
        {
            
            UIView *viewss=(UIView *)tmpView;
            if(viewss.tag==3)   //判断是否满足自己要删除的子视图的条件
            {
                [tmpView removeFromSuperview]; //删除子视图
                
                break;  //跳出for循环，因为子视图已经找到，无须往下遍历
            }
            
        }
    }

    NSArray *homear=[[NSArray alloc]initWithArray:homears];
    [ScratchablelatexViewController mainView:homear andvctl:self andtitlestr:homear];
}
#pragma mark-读取数据
-(void)readeData
{
    //存储设备
    _readerHomeArs=[[NSMutableArray alloc]initWithCapacity:0];
    //存储设备
    _readerEquipmentArs=[[NSMutableArray alloc]initWithCapacity:0];
    //存储房间编号
    _readerHomecodeArs=[[NSMutableArray alloc]initWithCapacity:0];
    //存储房间及设备
    _homeAequipmentars=[[NSMutableArray alloc]initWithCapacity:0];
    // 读取Documents/stu.plist的内容，实例化NSDictionary
    NSDictionary *dicts = [NSDictionary dictionaryWithContentsOfFile:_documents];
    
//    NSLog(@"%@==%@", [dicts allKeys],[dicts allValues] );
    [_readerHomecodeArs addObjectsFromArray:[dicts allKeys]];
    [_homeAequipmentars addObjectsFromArray:[dicts allValues]];
    for (int i=0; i<[dicts allValues].count; i++)
    {
        
//        NSLog(@"%@",[[_homeAequipmentars objectAtIndex:i] allValues]);
        
        [_readerEquipmentArs addObject:[[[_homeAequipmentars objectAtIndex:i] allValues] objectAtIndex:0]];
        [_readerHomeArs addObject:[[[_homeAequipmentars objectAtIndex:i] allKeys] objectAtIndex:0]];
//        NSLog(@"==%@",_readerHomeArs[i]);
    }
//    NSLog(@"==%@",_readerHomeArs[3]);
    
    [self createJIU:_readerHomeArs ande:_readerHomeArs];
}
#pragma mark-权限按钮
-(void)setviewinfo
{
    [MBProgressHUD showSuccess:@"权限按钮"];

}
#pragma mark-存储数据
-(void)saveData:(NSMutableDictionary *)homedicts
{
    //文件路径
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    _documents =[[array objectAtIndex:0] stringByAppendingString:@"/home.plist"];
//    NSLog(@"%@",_documents);
    if (!_documents) {
        NSLog(@"Documents 目录未找到");
    }
    //存储临时文件
    if([homedicts writeToFile:_documents atomically:YES])
    {
        NSLog(@"写入成功！");
        [self readeData];
    }else
    {
        NSLog(@"写入sb！");
    }

}
#pragma mark-图片单击触发事件
-(void)onClickImage:(UITapGestureRecognizer *)tap
{
    
    _mainsubappar=[[NSMutableArray alloc]initWithCapacity:0];
    [_mainsubappar removeAllObjects];
    UIView *view=tap.view;
    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"图片单击触发事件%@",_readerHomeArs[(int)view.tag]]];
    NSArray *arrsu=_readerEquipmentArs[(int)view.tag];
    [_mainsubappar addObjectsFromArray:arrsu];
    RoomequipmentViewController  *ket;
     ket.roomName=_readerHomeArs[(int)view.tag];
     ket =[[RoomequipmentViewController alloc]init];
    //属性传值
    ket.subAr=_mainsubappar;
   
//    NSLog(@"图片被点击!%@",_readerHomecodeArs[(int)view.tag]);
    ket.roombian=_readerHomecodeArs[(int)view.tag];
    
       [self.navigationController pushViewController:ket animated:YES];
//    NSLog(@"图片被点击!%ld",(long)view.tag);
}

#pragma mark-图片长按触发的事件(重命名and删除)
- (void)handleTableviewCellLongPressed:(UILongPressGestureRecognizer *)longbtn
{
     UIView *views=  longbtn.view;
    int homeTag=(int)views.tag;
    
//    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@图片长按触发的事件",_readerHomeArs[homeTag]]];
    
    NSString *title = NSLocalizedString(@"编辑界面", nil);
    NSString *message = NSLocalizedString(@"请选择删除图标or重命名", nil);
    NSString *deleteButtonTitle = NSLocalizedString(@"删除图标", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"重命名", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:deleteButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
    {
//        NSLog(@"删除图标%lu",(unsigned long)_readerHomecodeArs.count);

        [self deleteHome:homeTag];

    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
     
        NSLog(@"重命名");
        [self updateName:homeTag];
       
    }];
    UIAlertAction *cancelAction= [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {}];
    // Add the actions.
    
    [alertController addAction:otherAction];
    [alertController addAction:deleteAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    NSLog(@"图片长按触发的事件");
    
}
#pragma mark-删除
-(void)deleteHome:(int)homeTag
{
//    NSLog(@"^^^^^^^^^%@,%@",[_readerHomeArs objectAtIndex:homeTag],[_readerHomecodeArs objectAtIndex:homeTag]);
    [_homedicts removeObjectForKey:[_readerHomecodeArs objectAtIndex:homeTag]];
//    NSLog(@"%lu",(unsigned long)_homedicts.count);
    //写入数据，并读取，
    [self saveData:_homedicts];
}
#pragma mark-重名名
-(void)updateName:(int)homeTag
{
    _updateNameId=homeTag;
    updateViewController *updatevctl=[[updateViewController alloc]init];
    //        NSLog(@"%@",_readerHomeArs[homeTag]);
    updatevctl.delegate=self;
    updatevctl.nameeds=_readerHomeArs[homeTag];
    [self.navigationController pushViewController:updatevctl animated:YES];
    
    
    NSLog(@"%@",_nameds);
    //        _readerEquipmentArs[homeTag]=_nameds;
}
#pragma marek-代理的方法
-(void)getNewname:(NSString *)named
{
    _nameds=named;
    NSLog(@"%@++++++%@",_nameds,[[[_homedicts objectForKey:[_readerHomecodeArs objectAtIndex:_updateNameId]] allKeys]objectAtIndex:0]);
    if (_updateNameId || named)
    {
        return;
    }

//   [[[_homedicts objectForKey:[_readerHomecodeArs objectAtIndex:_updateNameId]] allKeys]objectAtIndex:0]=named;
    //写入数据，并读取，
    [self saveData:_homedicts];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
