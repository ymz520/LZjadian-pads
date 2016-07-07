//
//  TVSViewController.m
//  LZjadian
//
//  Created by 张 荣桂 on 16/4/5.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "TVSViewController.h"
#import "Masonry.h"
@interface TVSViewController ()
{
    UIButton *backbtn;
}
@end

@implementation TVSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createtv];
}
-(void)createtv
{
    self.view.backgroundColor=[UIColor grayColor];
    int totalloc=5;
    CGFloat appvieww=self.view.frame.size.width/12;
    CGFloat appviewh=appvieww/4;
    CGFloat margin=((self.view.frame.size.width-totalloc*appvieww)/(totalloc+1))/2;
    CGFloat appviewSecondh=appvieww;
    NSString *titlestr;
    NSArray *topBtnArs=[[NSArray alloc]initWithObjects:@"机顶盒",@"机顶盒",@"机顶盒",@"机顶盒",@"机顶盒",@"IPTV",@"卫星",@"电脑",@"锁定",@"信号源", nil];
//    NSArray *zBtnArs=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"-/--",@"*",@"#",@"设置",@"回看", nil];
    [self createBtn:topBtnArs andbtnW:appvieww andbtnH:appviewh andMargin:margin andbtnColor:[UIColor orangeColor]];
    int btnrow=9/5;
    CGFloat btntopy=margin+(margin+appviewh)*btnrow+64+appviewh;
    for (int i=0; i<15; i++)
    {
        CGFloat appviewx;
        CGFloat appviewy;
        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        appviewx=margin*7/2+(margin+appvieww)*loc;
        appviewy=margin+(margin+appviewSecondh)*row;
        //创建uiview控件
        UIButton *btn2=[UIButton new];
        btn2.backgroundColor=[UIColor orangeColor];
        btn2.layer.cornerRadius=5;
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize:appvieww/4];
        titlestr=@"";
        switch (i) {
            case 0:
                [btn2 setImage:[UIImage imageNamed:@"jingy"] forState:UIControlStateNormal];
                break;
            case 1:
                titlestr=@"主页";
                btn2.backgroundColor=[UIColor colorWithRed:143/255.0 green:143/255.0 blue:143/255.0 alpha:1];;
                break;
            case 2:
                btn2.backgroundColor=[UIColor colorWithRed:194/255.0 green:160/255.0 blue:48/255.0 alpha:1];
                [btn2 setImage:[UIImage imageNamed:@"top"] forState:UIControlStateNormal];
                break;
            case 3:
                titlestr=@"菜单";
                btn2.backgroundColor=[UIColor colorWithRed:143/255.0 green:143/255.0 blue:143/255.0 alpha:1];
                break;
            case 4:
                titlestr=@"多画面";
                btn2.backgroundColor=[UIColor colorWithRed:45/255.0 green:107/255.0 blue:180/255.0 alpha:1];
                break;
            case 5:
                btn2.backgroundColor=[UIColor colorWithRed:45/255.0 green:107/255.0 blue:180/255.0 alpha:1];
                [btn2 setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];                break;
            case 6:
                btn2.backgroundColor=[UIColor colorWithRed:129/255.0 green:157/255.0 blue:39/255.0 alpha:1];
                [btn2 setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];                break;
                break;
            case 7:
                btn2.backgroundColor=[UIColor colorWithRed:167/255.0 green:30/255.0 blue:41/255.0 alpha:1];
                titlestr=@"确认";
                break;
            case 8:
                btn2.backgroundColor=[UIColor colorWithRed:121/255.0 green:178/255.0 blue:208/255.0 alpha:1];
                [btn2 setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];                 break;
            case 9:
                btn2.backgroundColor=[UIColor colorWithRed:198/255.0 green:108/255.0 blue:68/255.0 alpha:1];
                [btn2 setImage:[UIImage imageNamed:@"top"] forState:UIControlStateNormal];               break;
            case 10:
                //                titlestr=@"多画面";
                btn2.backgroundColor=[UIColor colorWithRed:45/255.0 green:107/255.0 blue:180/255.0 alpha:1];
                [btn2 setImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
                break;
            case 11:
                titlestr=@"返回";
                btn2.backgroundColor=[UIColor colorWithRed:143/255.0 green:143/255.0 blue:143/255.0 alpha:1];
                [btn2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];                break;
            case 12:
                btn2.backgroundColor=[UIColor colorWithRed:183/255.0 green:100/255.0 blue:63/255.0 alpha:1];
                [btn2 setImage:[UIImage imageNamed:@"botmot"] forState:UIControlStateNormal];                break;
                break;
            case 13:
                btn2.backgroundColor=[UIColor colorWithRed:143/255.0 green:143/255.0 blue:143/255.0 alpha:1];
                titlestr=@"3D";
                break;
            case 14:
                btn2.backgroundColor=[UIColor colorWithRed:183/255.0 green:100/255.0 blue:63/255.0 alpha:1];
                [btn2 setImage:[UIImage imageNamed:@"botmot"] forState:UIControlStateNormal];                 break;
            default:
                break;
        }
        
        [btn2 setTitle:titlestr forState:UIControlStateNormal];
        //        自动布局
        [self.view addSubview:btn2];
        //约束2
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make)
         {
             
             make.height.mas_equalTo(appviewSecondh);
             make.width.mas_equalTo(appvieww);
             make.left.equalTo(self.view).with.offset(appviewx);
             make.top.equalTo(self.view).with.offset(btntopy+margin+appviewy);
         }];
    }
    int btnInrow=14/5;
  
    CGFloat btniny=margin+(margin+appviewSecondh)*btnInrow+btntopy+margin+appviewSecondh;
//    [self createBtn:zBtnArs andbtnW:appvieww andbtnH:appvieww andMargin:margin andbtnColor:[UIColor colorWithRed:129/255.0 green:157/255.0 blue:39/255.0 alpha:1]];
    for (int i=0; i<15; i++)
    {
        CGFloat appviewx;
        CGFloat appviewy;
        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        appviewx=margin*7/2+(margin+appvieww)*loc;
        appviewy=margin+(margin+appviewSecondh)*row;
        //创建uiview控件
        UIButton *btn1=[UIButton new];
        btn1.backgroundColor=[UIColor colorWithRed:129/255.0 green:157/255.0 blue:39/255.0 alpha:1];
        btn1.layer.cornerRadius=5;
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:appvieww/3];
        titlestr=[NSString stringWithFormat:@"%d",i+1];
        switch (i)
        {
            case 9:
                titlestr=@"0";
                break;
            case 10:
                titlestr=@"-/--";
                break;
            case 11:
                titlestr=@"*";
                break;
            case 12:
                
                titlestr=@"#";
                break;
            case 13:
                titlestr=@"设置";
                break;
            case 14:
                titlestr=@"回看";
                break;
            default:
                break;
        }
        [btn1 setTitle:titlestr forState:UIControlStateNormal];
        //        自动布局
        [self.view addSubview:btn1];
        //约束2
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make)
         {
             
             make.height.mas_equalTo(appviewSecondh);
             make.width.mas_equalTo(appvieww);
             make.left.equalTo(self.view).with.offset(appviewx);
             make.top.equalTo(self.view).with.offset( btniny+margin+appviewy);
         }];
    }
    int btnlastrow=14/5;
    CGFloat btnasty=margin+(margin+appviewSecondh)*btnInrow+btniny+margin+appviewSecondh;
    
    for (int i=0; i<5; i++)
    {
        CGFloat appviewx;
        CGFloat appviewy;
        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        appviewx=margin*7/2+(margin+appvieww)*loc;
        appviewy=margin+(margin+appviewh)*row;
        //创建uiview控件
        UIButton *btn1=[UIButton new];
        btn1.backgroundColor=[UIColor colorWithRed:183/255.0 green:100/255.0 blue:63/255.0 alpha:1];
        btn1.layer.cornerRadius=5;
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:8];
        //        titlestr=@"机顶盒";
        switch (i) {
            case 0:
                titlestr=@"直播/定时";
                break;
            case 1:
                btn1.backgroundColor=[UIColor colorWithRed:39/255.0 green:89/255.0 blue:49/255.0 alpha:1];
                titlestr=@"广播/回收";
                break;
            case 2:
                btn1.backgroundColor=[UIColor colorWithRed:195/255.0 green:183/255.0 blue:51/255.0 alpha:1];
                titlestr=@"点播/搜台";
                break;
            case 3:
                btn1.backgroundColor=[UIColor colorWithRed:39/255.0 green:90/255.0 blue:167/255.0 alpha:1];
                titlestr=@"邮件/资讯";
                break;
            case 4:
                btn1.backgroundColor=[UIColor redColor];
                titlestr=@"切换/模式";
                break;
                
            default:
                break;
        }
        [btn1 setTitle:titlestr forState:UIControlStateNormal];
        //        自动布局
        [self.view addSubview:btn1];
        //约束2
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make)
         {
             
             make.height.mas_equalTo(appviewh);
             make.width.mas_equalTo(appvieww);
             make.left.equalTo(self.view).with.offset(appviewx);
             make.top.equalTo(self.view).with.offset(btnasty+margin/2);
         }];
    }
}
#pragma mark-创建按钮
-(void)createBtn:(NSArray *)btnars andbtnW:(CGFloat)btnW andbtnH:(CGFloat)btnH andMargin:(CGFloat)Margin andbtnColor:(UIColor *)btnColor
{
    for (int i=0; i<btnars.count; i++)
    {
        CGFloat appviewx;
        CGFloat appviewy;
        int row=i/5;//行号
                //1/3=0,2/3=0,3/3=1;
        int loc=i%5;//列号
        appviewx=Margin*7/2+(Margin+btnW)*loc;
        appviewy=Margin+(Margin+btnH)*row;
        
        //创建uiview控件
        UIButton *btn1=[UIButton new];
        btn1.backgroundColor=btnColor;
        btn1.layer.cornerRadius=5;
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:btnH/2];
        NSString  *titlestr=btnars[i];
        [btn1 setTitle:titlestr forState:UIControlStateNormal];
        //        自动布局
        [self.view addSubview:btn1];
        //约束2
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.height.mas_equalTo(btnH);
             make.width.mas_equalTo(btnW);
             make.left.equalTo(self.view).with.offset(appviewx);
             make.top.equalTo(self.view).with.offset(appviewy+64);
         }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
