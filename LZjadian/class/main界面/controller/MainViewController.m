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
#import "FMDB.h"
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
    NSArray *_roomCode;//房间编码
    FMDatabase *_db;

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
    [self showData];
    //数据库操作
    [self SqliteDB];
    //存数据
    [self saveData:_homedicts];
    
  
    
   
}
#pragma mark-数据库操作
-(void)SqliteDB
{
    //搜索路径的目录域
    NSString *cachePath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath=[cachePath stringByAppendingString:@"/Room.sqlite"];
    NSLog(@"%@",filepath);
    //打开数据库
    //1.创建数据库实例
    _db=[FMDatabase databaseWithPath:filepath];
    [_db open];
   BOOL iscreateTable=[_db executeUpdate:@"create table if not exists RoomTablee (id integer primary key autoincrement,roomName text,roomCode text)"];
  BOOL iscreateTableTwo=[_db executeUpdate:@"create table if not exists equipmentTable (roomid integer,equipmentName text,equipmentCode text)"];
    
    if (iscreateTable && iscreateTableTwo) {
        NSLog(@"successful");
    }else
    {
        NSLog(@"failure");
    }
    
    
}
#pragma mark-插入数据（房间＋编码）
-(void)adddate:(NSArray *)roomcode androom:(NSMutableArray *)roomar
{
//    andE:(NSMutableArray *)EquipmentArs
    //数据库操作：add，delete，update都属于update
    //参数：sqlite语句
    BOOL isinsert;
    for (int i=0; i<_readerHomeArs.count; i++)
    {

        isinsert=[_db executeUpdate:@"insert into RoomTablee (roomName,roomCode)values(?,?)",roomar[i],roomcode[i]];
        if (isinsert)
        {
            NSLog(@"插入成功");
        }else
        {
            NSLog(@"插入失败");
        }
        
    }


}
#pragma mark-插入数据（设备＋编码）
-(void)adddateE:(int) roomid andequipment:(NSMutableArray *)equipmentar
{
    //    andE:(NSMutableArray *)EquipmentArs
    //数据库操作：add，delete，update都属于update
    //参数：sqlite语句
//    BOOL isinsert;
//    for (int i=0; i<_readerHomeArs.count; i++)
//    {
//        
//        isinsert=[_db executeUpdate:@"insert into equipmentTable (roomid,equipmentName)values(?,?)",roomid,equipmentar[i]];
//        if (isinsert)
//        {
//            NSLog(@"插入成功");
//        }else
//        {
//            NSLog(@"插入失败");
//        }
//        
//    }
    
    
}
#pragma mark-数据
-(void)showData
{
    _roomCode=[NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"W",@"J",@"K",@"Y", nil];
    _homedicts = [NSMutableDictionary dictionary];
    _equipmentapps=[[NSMutableArray alloc]initWithCapacity:0];
    _eqars=@[@{@"客厅":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"空调",@"地暖",@"音乐",@"窗帘",@"饮水",@"插座",@"情景模式",@"离家模式",nil]},@{@"餐厅":[[NSArray alloc]initWithObjects:@"灯光",@"燃气",@"自来水",@"电器",@"插座",nil]},@{@"厨房":[[NSArray alloc]initWithObjects:@"灯光",@"燃气",@"自来水",@"电器",@"插座",nil]},@{@"主卧室":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"空调",@"地暖",@"音乐",@"窗帘",@"插座",@"情景模式",@"电动床",nil]},@{@"女儿房":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"空调",@"地暖",@"音乐",@"窗帘",@"插座",@"情景模式",@"电动床",nil]},@{@"儿子房":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"空调",@"地暖",@"音乐",@"窗帘",@"插座",@"情景模式",@"电动床",nil]},@{@"老人房":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"空调",@"地暖",@"音乐",@"窗帘",@"插座",@"情景模式",@"电动床",nil]},@{@"书房":[[NSArray alloc]initWithObjects:@"灯光",@"音乐",@"空调",@"地暖",@"窗帘",@"插座",nil]},@{@"主卫生间":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"换气",@"浴霸",@"洗衣机",@"窗帘",@"插座",nil]},@{@"次卫生间":[[NSArray alloc]initWithObjects:@"灯光",@"电视",@"换气",@"浴霸",@"洗衣机",@"窗帘",@"插座",nil]},@{@"南阳台":[[NSArray alloc]initWithObjects:@"灯光",@"洗衣机",@"衣架",@"插座",nil]},@{@"北阳台":[[NSArray alloc]initWithObjects:@"灯光",@"洗衣机",@"衣架",@"插座",nil]},];
    
    [_equipmentapps addObjectsFromArray:_eqars];
    for (int i=0;i<_eqars.count ; i++)
    {
        [_homedicts setObject:_equipmentapps[i] forKey:_roomCode[i]];
    }
    

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
    //存储房间
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
        [_readerEquipmentArs addObject:[[[_homeAequipmentars objectAtIndex:i] allValues] objectAtIndex:0]];
        [_readerHomeArs addObject:[[[_homeAequipmentars objectAtIndex:i] allKeys] objectAtIndex:0]];
    }
    [self createJIU:_readerHomeArs ande:_readerHomeArs];
    BOOL isopen=[_db open];
    if (isopen)
    {
        //add
        [self adddate:_roomCode androom:_readerHomeArs];
        NSLog(@"successful");
        [_db close];
    }else
    {
        NSLog(@"failure");
    }
    
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
-(void)onClickImage:(UIButton *)tap
{
    
    _mainsubappar=[[NSMutableArray alloc]initWithCapacity:0];
    [_mainsubappar removeAllObjects];
    UIView *view=[tap superview];
//    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"图片单击触发事件%@",_readerHomeArs[(int)view.tag]]];
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
#pragma mark- 向数据库存入设备
    BOOL isopen=[_db open];
    if (isopen)
    {
        //add
        [self adddateE:(((int)view.tag)+1) andequipment:_mainsubappar];
        NSLog(@"successful");
        [_db close];
    }else
    {
        NSLog(@"failure");
    }
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
//    NSLog(@"图片长按触发的事件");
    
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
}
#pragma marek-代理的方法
-(void)getNewname:(NSString *)named
{
    _nameds=named;
    if (_updateNameId || named)
    {
        return;
    }
    //写入数据，并读取，
    [self saveData:_homedicts];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
