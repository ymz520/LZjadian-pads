//
//  ketingViewController.m
//  LZjadian
//
//  Created by 张 荣桂 on 16/3/15.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//
#import "RoomequipmentViewController.h"
#import "ScratchablelatexViewController.h"
#import "equipmentViewController.h"
#import "MBProgressHUD+MJ.h"
#import "Masonry.h"
#import "TVSViewController.h"
#import "SocketTcp.h"
@interface RoomequipmentViewController ()
{
    SocketTcp *_scoketClass;
    NSArray *_subappar;
    NSArray *_sar;
    int _kettag;
    UIButton *backbtn;
    BOOL isBool;
    NSString *_readedatas;//读取的字符串
}
@end

@implementation RoomequipmentViewController
//自定义初始化
 -(instancetype)init
{
    //连接tcp
    [self tcpCreadeW];
    
    if (self = [super init])
    {
        
    }
    return self;
}
#pragma mark_tcp通讯
-(void)tcpCreadeW
{
    //初史化
    _scoketClass=[[SocketTcp alloc]init];
    //建立连接
    if ([_scoketClass connectSocket])
    {
        //发送数据
        //AZ01010000000000
        [_scoketClass sendMeg:[NSString stringWithFormat:@"%@Z01010000000000",_roombian]];
        
    }else
    {
        [MBProgressHUD showMessage:@"连接失败"];
        
    }
    if (_scoketClass.readeData==nil)
    {
        [MBProgressHUD showError:@"读取失败"];
    }else
    {
        [MBProgressHUD showSuccess:@"读取成功"];
        //读取数据A8t1f2f6t5t7t4f3t00000000
        _readedatas=_scoketClass.readeData;
        [_scoketClass cutconnect];
    }
    NSLog(@"发送数据：%@读取数据：%@",[NSString stringWithFormat:@"%@z01010000000000",_roombian],_readedatas);
    //根据读取字符串加载图标
    //断开连接
    //[_scoketClass cutconnect];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
   //发送数据
//    [_scoketClass sendMeg:@"AZ01010000000000"];
    NSMutableArray *mar=[[NSMutableArray alloc]initWithCapacity:0];
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
    for (int i=0; i<_subAr.count; i++)
    {
        [mar addObject:[NSString stringWithFormat:@"%@0",_subAr[i]]];
//        NSLog(@"%@",mar[i]);
    }
    _subappar=_subAr;
    _sar=mar;
    [ScratchablelatexViewController mainView:_sar andvctl:self andtitlestr:_subappar];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self tcpCreadeW];
    isBool=YES;
    self.view.backgroundColor=[UIColor grayColor];
}

#pragma mark-单击图片事件
-(void)onClickImage:(UITapGestureRecognizer *)tap
{
    UIView *view=tap.view;
    int index=(int)view.tag;
     UIImageView *imgv=(UIImageView *)[view viewWithTag:index+1];
    imgv.image=nil;
    
    #pragma mark_tcp传值（(那个房间)_roomName,（的什么设备））
//    [self sendMeg:@"1111"];
    //如果处于关闭状态单击后将处于开启状态
    if(isBool)
    {
        isBool=NO;
       
        imgv.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@1.png",_subappar[index]]];
    }else
    {
        imgv.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@0.png",_subappar[index]]];
        isBool=YES;
    }
    
    NSLog(@"图片被点击!%ld",(long)view.tag);
}
#pragma mark-如果处于关闭状态单击后将处于开启状态
#pragma mark-图片长按触发的事件  ＊＊＊＊＊
- (void)handleTableviewCellLongPressed:(UILongPressGestureRecognizer *)longbtn
{
    //UIGestureRecognizerStateBegan手势识别器状态开始
    if([longbtn state] == UIGestureRecognizerStateBegan)
    {
        UIView *view=longbtn.view;
        equipmentViewController *dgvctl=[[equipmentViewController alloc]init];
        dgvctl.tags=view.tag;
        dgvctl.subsar=_subappar;
        if ([_subappar[view.tag] isEqualToString:@"电视"])
        {
            TVSViewController *tvctl=[[TVSViewController alloc]init];
            [self.navigationController pushViewController:tvctl animated:YES];
            //        [self presentViewController:tvctl animated:YES completion:nil];
            return;
        }
        NSLog(@"123");
        [self.navigationController pushViewController:dgvctl animated:YES];
        //    [self presentViewController:dgvctl animated:YES completion:nil];
        NSLog(@"图片被长按!%ld",(long)view.tag);
        NSLog(@"-----%lu----",(unsigned long)_subappar.count);
    
    }
    
}

@end
