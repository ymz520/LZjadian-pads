//
//  JIUViewController.m
//  LZjadian
//
//  Created by 张 荣桂 on 16/3/16.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "ScratchablelatexViewController.h"
#import "RoomequipmentViewController.h"
#import "Masonry.h"
#import "equipmentViewController.h"
@interface ScratchablelatexViewController ()

@end

@implementation ScratchablelatexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
+(void)mainView:(NSArray *)appsar andvctl:(UIViewController *)vctl andtitlestr:(NSArray *)titlestr
{
    NSLog(@"%lu",(unsigned long)appsar.count);
     UIView *subviews=[[UIView alloc]initWithFrame:vctl.view.bounds];
    subviews.tag=3;
    NSLog(@"＝＝＝＝%@",NSStringFromClass([vctl class]));
    if ([NSStringFromClass([vctl class]) isEqualToString:@"dengGuangViewController"])
    {
        subviews.frame=CGRectMake(0, vctl.view.frame.size.height/4+1, vctl.view.frame.size.width, vctl.view.frame.size.height);
        [[vctl.view viewWithTag:2] addSubview:subviews];
    }else
    {
        
        [vctl.view addSubview:subviews];
        NSLog(@"%lu",(unsigned long)appsar.count);
    
    }
    //2.完成布局设计
    //三列
    int totalloc=3;
    CGFloat appvieww=(subviews.frame.size.width*0.25)/2;
    CGFloat appviewh=(appvieww+20)/2;
    
    CGFloat margin=(subviews.frame.size.width-totalloc*appvieww)/(totalloc+1);
    
//    int count=(int)appsar.count;
    for (int i=0; i<appsar.count; i++)
    {
        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        CGFloat appviewx=margin+(margin+appvieww)*loc;
        CGFloat appviewy=margin+(margin+appviewh)*row;
        //创建uiview控件
        UIView *appview=[UIView new];
        //        自动布局
        [subviews addSubview:appview];
        //约束2
        [appview mas_makeConstraints:^(MASConstraintMaker *make)
        {

            make.height.mas_equalTo(appviewh);
            make.width.mas_equalTo(appvieww);
            make.left.equalTo(subviews).with.offset(appviewx);
            make.top.equalTo(subviews).with.offset(appviewy+vctl.navigationController.navigationBar.bounds.size.height+20);
        }];
        
        //创建uiview控件中的子视图
        UIButton *appimageview=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, appvieww, appvieww)];
//        appimageview.tag=i;
        appview.tag=i;
        appimageview.tag=i+1;
//        NSLog(@"%@",[appsar[i] objectAtIndex:0]);
        UIImage *appimage=[UIImage imageNamed:appsar[i]];
        [appimageview setBackgroundImage:appimage forState:UIControlStateNormal];
//        appimageview.image=appimage;
        [appimageview setContentMode:UIViewContentModeScaleAspectFit];
        [appview addSubview:appimageview];
        //点击图片
        [appimageview addTarget:vctl action:@selector(onClickImage:) forControlEvents:UIControlEventTouchUpInside];
        //创建文本标签
        UILabel *applable=[[UILabel alloc]initWithFrame:CGRectMake(0, appvieww, appvieww, 20)];
//        applable.tag=2;
        applable.textColor=[UIColor whiteColor];
        [applable setText:titlestr[i]];
        NSLog(@"%@",appsar[i]);
        [applable setTextAlignment:NSTextAlignmentCenter];
        [applable setFont:[UIFont systemFontOfSize:12.0]];
        [appview addSubview:applable];
        //让图片做出响应
//        appview.userInteractionEnabled=YES;
       
//        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:vctl action:@selector(onClickImage:)];
//        [appview addGestureRecognizer:singleTap];
        //长按图片
        //实例化长按手势监听
        UILongPressGestureRecognizer *longPress =
        [[UILongPressGestureRecognizer alloc] initWithTarget:vctl
                                                      action:@selector(handleTableviewCellLongPressed:)];
        //代理
//        longPress.delegate = vctl;
        longPress.minimumPressDuration = 0.5;
//        longPress.minimumPressDuration = 1.0;
//        将长按手势添加到需要实现长按操作的视图里
        [appview addGestureRecognizer:longPress];
        
        
    }
    

}


@end
