//
//  dengGuangViewController.m
//  LZjadian
//
//  Created by 张 荣桂 on 16/3/18.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "equipmentViewController.h"
#import "Masonry.h"
#import "MBProgressHUD+MJ.h"
#import "ScratchablelatexViewController.h"
#import "TVSViewController.h"
#import "SliderTableViewCell.h"
#import "sconedSliderTableViewCell.h"
#import "FGThrowSlider.h"
#import "FGThrowSlider.h"
#import "OtherTableViewCell.h"
#import "SocketTcp.h"
#import "curtainTableViewCell.h"
@interface equipmentViewController ()
<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,FGThrowSliderDelegate>
{
    int _pages;
    CGFloat _margin;
    UIScrollView *scr;
    UIScrollView *_XiaScv;
    UIButton *backbtn;
    BOOL _flag;
    BOOL flag;
    BOOL isBool;
    NSArray *_ars;
    NSArray *_liars;
    CGFloat imgvW;
    NSArray *_tabvCellcount;
    UITableView *_lighttab;
    UITableView *_redtab;
    NSArray *_curtainAr;
}
@property(nonatomic,strong)SocketTcp *scoketClass;
@end

@implementation equipmentViewController
//懒加载
-(SocketTcp *)scoketClass
{
    if (!_scoketClass)
    {
        //初史化
        _scoketClass=[[SocketTcp alloc]init];
    }
    return _scoketClass;

}
#pragma mark-初始化方法(建立连接)
-(instancetype)init
{
    if (self = [super init])
    {
        //连接tcp
        isBool=[self.scoketClass connectSocket];
    }
    return self;
    

}
#pragma mark-发送数据
-(void)write:(NSString *)str
{
    //建立连接
    if (isBool)
    {
        //发送数据AZ01010000000000
        [_scoketClass sendMeg:[NSString stringWithFormat:@"%@Z01010000000000",str]];
    }else
    {
        [MBProgressHUD showMessage:@"连接失败,不能发送数据"];
        
    }

}
#pragma mark-读取数据
-(NSString *)readeData
{
    NSString *readerdate=nil;
    if (_scoketClass.readeData==nil)
    {
        [MBProgressHUD showError:@"读取失败"];
    }else
    {
        [MBProgressHUD showSuccess:@"读取成功"];
        //读取数据A8t1f2f6t5t7t4f3t00000000
        readerdate=_scoketClass.readeData;
        //        [_scoketClass cutconnect];
    }
    NSLog(@"读取数据：%@",readerdate);
    return readerdate;
   
    
    //根据读取字符串加载图标
   

}
#pragma mark-断开连接
-(void)cutCon
{
    //断开连接
    [_scoketClass cutconnect];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    imgvW=self.view.frame.size.width*0.25;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    //创建上滚动视图
    [self createSCRView];
    [UIView animateWithDuration:0.2 animations:^{
        scr.contentOffset=CGPointMake(_tags*(_margin+imgvW), 0);
        _XiaScv.contentOffset=CGPointMake(_tags*self.view.frame.size.width, 0);
        ((UIImageView *)scr.subviews[_tags]).image=[UIImage imageNamed:[NSString stringWithFormat:@"%@1",_subsar[_tags]]];
    }];
    for (int i=0; i<_subsar.count; i++)
    {
        if (i!=_tags) {
            ((UIImageView *)scr.subviews[i]).image=[UIImage imageNamed:[NSString stringWithFormat:@"%@00",_subsar[i]]];
        }
    }
    _flag=YES;
    self.view.backgroundColor=[UIColor blackColor];

}
#pragma mark-创建上滚动视图
-(void)createSCRView
{
 scr=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/4-55)];
    NSLog(@"%.2f",scr.bounds.size.height);
    
    scr.tag=1;
    //判断有几页
    if(self.subsar.count%3==0)
    {
        _pages=(int)self.subsar.count/3;
        _margin=(_pages*self.view.bounds.size.width-self.subsar.count*imgvW)/(_subsar.count+1);
        
    }else
    {
        _pages=((int)self.subsar.count/3)+1;
        int counts=(int)(_subsar.count-(_subsar.count%3));
        _margin=(((_pages-1)*self.view.bounds.size.width)-counts*imgvW)/(counts+1);
    }
    //有多少列
    NSInteger  lie=_subsar.count;
    for (int i=0; i<_subsar.count; i++)
    {
        int loc=i%lie;//列号
        CGFloat appviewx=_margin+(_margin+imgvW)*loc;
        UIImageView *imageViews=[[UIImageView alloc] initWithFrame:CGRectMake(appviewx, _margin+(_margin+imgvW)*(0%_subsar.count), imgvW/2, imgvW/2)];
//        if (i==0)
//        {
//            imageViews.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@1",_subsar[i]]];
//        }else{
//        imageViews.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@00",_subsar[i]]];
//        NSLog(@"++%@++",[NSString stringWithFormat:@"%@00",_subsar[i]]);
//        }
        //通过tag值传值
        imageViews.tag=i;
//         给当前图片添加点击事件
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchesImage:)];
        imageViews.userInteractionEnabled=YES;
        [imageViews addGestureRecognizer:tap];
        
        [scr addSubview:imageViews];
//        scr.contentOffset=CGPointMake(imageViews.frame.origin.x-_margin, 0);
    }
    //图片包含的大小
    //    设置内容大小 内容大小必须大于视图的尺寸
    scr.contentSize=CGSizeMake(_pages*self.view.bounds.size.width, self.view.bounds.size.height/4-55);
    
    scr.backgroundColor=[UIColor grayColor];
    //    是否显示横向滚动条
    scr.showsHorizontalScrollIndicator=NO;
    //    纵向
    scr.showsVerticalScrollIndicator=NO;
    //   是否有回弹效果
    scr.bounces=NO;
    scr.delegate=self;
    [self.view addSubview:scr];
    [self createXiaSCrview:0];
}
- (void)touchesImage:(UIGestureRecognizer *)gesture{
    
    UIImageView *images=(UIImageView *)gesture.view;
    [UIView animateWithDuration:0.2 animations:^{
        scr.contentOffset=CGPointMake(images.frame.origin.x-_margin, 0);
        _XiaScv.contentOffset=CGPointMake(images.tag*self.view.frame.size.width, 0);
    images.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@1",_subsar[images.tag]]];
    }];
    for (int i=0; i<_subsar.count; i++)
    {
        if (i!=images.tag) {
            ((UIImageView *)scr.subviews[i]).image=[UIImage imageNamed:[NSString stringWithFormat:@"%@00",_subsar[i]]];
        }
    }
    
    
//    NSLog(@"===========%f=====%f",scr.contentOffset.x,images.frame.origin.x);
    
}
#pragma mark-创建下边滚动视图
-(void)createXiaSCrview:(int)tags
{
    _XiaScv=[[UIScrollView alloc] initWithFrame:CGRectMake(0, scr.frame.size.height+scr.frame.origin.y+1, self.view.bounds.size.width, self.view.bounds.size.height*3/4)];
    _XiaScv.tag=2;
    _XiaScv.backgroundColor=[UIColor grayColor];
    _XiaScv.contentSize=CGSizeMake(_subsar.count*self.view.bounds.size.width, self.view.bounds.size.height);
    _XiaScv.delegate=self;
    for (int i=0; i<_subsar.count; i++)
    {
        
        UIView *subviews=[[UIView alloc]initWithFrame:CGRectMake(i*self.view.bounds.size.width, 0, _XiaScv.frame.size.width,  _XiaScv.frame.size.height)];
        //根据数组下标创建不同的视图
        [self createSubView:i andview:subviews];
       NSString *sengStr=[NSString stringWithFormat:@"home:%@,equipment:%@",@"",_subsar[i]];
#pragma mark-发送消息，接收返归的slider的values
#pragma mark-发送数据 ＝＝那个房间＝＝＝对应的设备＝＝设备的状态
        [self write:sengStr];
        
        
        [_XiaScv addSubview:subviews];
        
    }
    //    是否显示横向滚动条
    _XiaScv.showsHorizontalScrollIndicator=NO;
    //    纵向
    _XiaScv.showsVerticalScrollIndicator=NO;
    //   是否有回弹效果
    _XiaScv.bounces=NO;
    _XiaScv.scrollEnabled=NO;
    _XiaScv.pagingEnabled=YES;
    [self.view addSubview:_XiaScv];
}
#pragma mark-根据数组下标创建不同的视图
-(void)createSubView:(int)index andview:(UIView *)vie
{
    for(UIView *view in [vie subviews])
    {
        [view removeFromSuperview];
        
    }
    if ([_subsar[index] isEqualToString:@"灯光"])
    {
        [self createTableView:vie andindex:index];
        //灯光调整界面
    }else if ([_subsar[index] isEqualToString:@"窗帘"])
    {
        
       _curtainAr=[[NSArray alloc]initWithObjects:@"窗纱",@"窗帘",@"窗纱",@"窗帘",@"遮光", nil];
        [self createTableView:vie andindex:3];
//         CGFloat imgvCurtainw=(vie.frame.size.width-4*_margin)/12;
        
//        //窗帘调整界面
//        [self createCurtainView:vie andars:_curtainAr andimgvw:imgvCurtainw andimgName:@"窗帘1.png" andright:@"窗帘图标-2"];
    
    }else if ([_subsar[index] isEqualToString:@"插座"])
    {
        CGFloat imgvDeviceW=(vie.frame.size.width-4*_margin)/6;
       //(vie.frame.size.height-5*_margin)/5
        CGFloat imgvDeviceh=56*imgvDeviceW/45;
         NSArray *ars=[[NSArray alloc]initWithObjects:@"图标-1",@"图标-2",@"图标-3",@"图标-4",@"图标-5", nil];
        [self createDianQ:vie andars:ars andimgvW:imgvDeviceW andimgvh:imgvDeviceh];
    }else if([_subsar[index] isEqualToString:@"音乐"])
    {
        [self createMusicView:vie];
        
    }else if([_subsar[index] isEqualToString:@"燃气"])
    {
        CGFloat imgvDeviceW=44.5;
        CGFloat imgvDeviceh=44.5;
        NSArray *ars=[[NSArray alloc]initWithObjects:@"燃气", nil];
        [self createDianQ:vie andars:ars andimgvW:imgvDeviceW andimgvh:imgvDeviceh];
    }else if([_subsar[index] isEqualToString:@"自来水"])
    {
        CGFloat imgvDeviceW=44.5;
        CGFloat imgvDeviceh=44.5;
        NSArray *ars=[[NSArray alloc]initWithObjects:@"自来水", nil];
        [self createDianQ:vie andars:ars andimgvW:imgvDeviceW andimgvh:imgvDeviceh];
    }else if ([_subsar[index]isEqualToString:@"电器"])
    {
        CGFloat imgvDeviceW=(vie.frame.size.width-4*_margin)/6;
        //(vie.frame.size.height-5*_margin)/5
        CGFloat imgvDeviceh=56*imgvDeviceW/45;
//        CGFloat imgvDeviceW=45;
//        CGFloat imgvDeviceh=56;
        NSArray *ars=[[NSArray alloc]initWithObjects:@"冰箱",@"微波炉",@"电饭煲",@"烤箱",@"备用", nil];
        [self createDianQ:vie andars:ars andimgvW:imgvDeviceW andimgvh:imgvDeviceh];
    }else if ([_subsar[index]isEqualToString:@"洗衣机"])
    {
        CGFloat imgvDeviceW=37.5;
        CGFloat imgvDeviceh=37.5;
        NSArray *ars=[[NSArray alloc]initWithObjects:@"水",@"电", nil];
        [self createDianQ:vie andars:ars andimgvW:imgvDeviceW andimgvh:imgvDeviceh];
    
    }else if ([_subsar[index]isEqualToString:@"浴霸"])
    {
        CGFloat imgvDeviceW=59.5;
        CGFloat imgvDeviceh=60;
        NSArray *ars=[[NSArray alloc]initWithObjects:@"浴霸-1",@"浴霸-1", nil];
        [self createDianQ:vie andars:ars andimgvW:imgvDeviceW andimgvh:imgvDeviceh];
        
    }else if ([_subsar[index]isEqualToString:@"换气"])
    {
        CGFloat imgvDeviceW=59.5;
        CGFloat imgvDeviceh=60;
        NSArray *ars=[[NSArray alloc]initWithObjects:@"换气", nil];
        [self createDianQ:vie andars:ars andimgvW:imgvDeviceW andimgvh:imgvDeviceh];
        
    }else if ([_subsar[index]isEqualToString:@"衣架"])
    {
        
        CGFloat imgvCurtainw=48;
        NSArray *ars=[[NSArray alloc]initWithObjects:@"高", nil];
        //窗帘调整界面
        [self createCurtainView:vie andars:ars andimgvw:imgvCurtainw andimgName:@"衣架1.png" andright:@"低"];
        
    }else if ([_subsar[index] isEqualToString:@"电视"])
    {
        
        [self createTv:vie];
    }else if ([_subsar[index] isEqualToString:@"电动床"])
    {
        [self createTableView:vie andindex:2];
//        CGFloat imgvCurtainw=59.5;
//        NSArray *ars=[[NSArray alloc]initWithObjects:@"头部图标",@"头部调节好脚部图标",@"脚部调节好图标", nil];
//        [self createBedView:vie andimgvw:imgvCurtainw];
    }else if ([_subsar[index]isEqualToString:@"情景模式"])
        
    {
       _ars=[[NSArray alloc]initWithObjects:@"情景模式开启状态-1",@"情景模式开启状态-2",@"情景模式开启状态-3",@"情景模式开启状态-4",@"情景模式开启状态-5",@"情景模式开启状态-8",@"情景模式开启状态-9", nil];
        NSArray *arsstr=[[NSArray alloc]initWithObjects:@"电灯",@"电视",@"空调",@"地暖",@"音乐",@"窗帘",@"插座", nil];
        [self createMode:vie andars:_ars andstr:arsstr];
    }else if ([_subsar[index]isEqualToString:@"离家模式"])
    {
        _liars=[[NSArray alloc]initWithObjects:@"离家模式关闭状态-1",@"离家模式关闭状态-2",@"离家模式关闭状态-3",@"离家模式关闭状态-4",@"离家模式关闭状态-5",@"离家模式关闭状态-6",@"离家模式关闭状态-7",@"离家模式关闭状态-8",@"离家模式关闭状态-9",@"离家模式关闭状态-10",@"离家模式关闭状态-11",@"离家模式关闭状态-12", nil];
        NSArray *arsstr=[[NSArray alloc]initWithObjects:@"客厅",@"餐厅",@"厨房",@"主卧室",@"女儿房",@"儿子房",@"老人房",@"书房",@"主卫生间",@"次卫生间",@"南阳台",@"北阳台", nil];
        [self createModes:vie andars:_liars andstr:arsstr];
    }else if ([_subsar[index]isEqualToString:@"地暖"])
    {
        
        [self createFloor:vie andindex:index];
        
    }else if ([_subsar[index]isEqualToString:@"空调"])
    {
        [self createFloor:vie andindex:index];
    }else if ([_subsar[index]isEqualToString:@"饮水"])
    {
        CGFloat imgvDeviceW=45;
        CGFloat imgvDeviceh=56;
        NSArray *ars=[[NSArray alloc]initWithObjects:@"自来水", nil];
        [self createDianQ:vie andars:ars andimgvW:imgvDeviceW andimgvh:imgvDeviceh];
    }
    
    
}
#pragma mark-电视
-(void)createTv:(UIView *)vie
{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(120, 160, 150, 60)];
    btn.backgroundColor=[UIColor redColor];
    [btn setTitle:@"电视遥控" forState:UIControlStateNormal];
    [vie addSubview:btn];
    [btn addTarget:self action:@selector(tiaoz) forControlEvents:UIControlEventTouchUpInside];
   
   
}
-(void)tiaoz
{
    TVSViewController *tvvctl=[[TVSViewController alloc]init];
    [self.navigationController pushViewController:tvvctl animated:YES];
}
#pragma maek-地暖
-(void)createFloor:(UIView *)vie andindex:(int)indexs
{
    for(UIView *view in [vie subviews])
    {
        [view removeFromSuperview];
        
    }
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(_margin, _margin*2, vie.bounds.size.width-_margin*2, 60)];
    btn.layer.cornerRadius=15;
    btn.backgroundColor=[UIColor colorWithRed:232/255.0 green:113/255.0 blue:48/255.0 alpha:1];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"制热" forState:UIControlStateNormal];
    btn.tag=6;
    [vie addSubview:btn];
    [btn addTarget:self action:@selector(heatclik:) forControlEvents:UIControlEventTouchUpInside];
    
        for (int i=0; i<6; i++)
        {
            UIButton *btns=[[UIButton alloc]init];
            int row=i/2;//行号
//            NSLog(@"%d",row);
            if ((i+1)%2==0)
            {
                btns.frame=CGRectMake(_margin+btn.bounds.size.width*2/3, btn.bounds.size.height+btn.frame.origin.y+(row+1)*5+row*btn.bounds.size.height, btn.bounds.size.width/3, btn.bounds.size.height);
            }else
            {
                
                btns.frame=CGRectMake(_margin, btn.bounds.size.height+btn.frame.origin.y+(row+1)*5+row*btn.bounds.size.height, btn.bounds.size.width/3, btn.bounds.size.height);
            }
//            NSLog(@"%.2f===%.2f",btns.frame.origin.x,btns.frame.origin.y);
            btns.layer.cornerRadius=15;
            if (row==1)
            {
                btns.backgroundColor=[UIColor colorWithRed:246/255.0 green:201/255.0 blue:60/255.0 alpha:1];
            }else
            {
                btns.backgroundColor=[UIColor colorWithRed:232/255.0 green:113/255.0 blue:48/255.0 alpha:1];
            }
            
            [btns setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btns setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [btns setTitle:@"制热i" forState:UIControlStateNormal];
            btns.tag=i+1;
            [vie addSubview:btns];
        }
        UIButton *btncenter=[[UIButton alloc]initWithFrame:CGRectMake(_margin+5+btn.bounds.size.width*1/3,btn.bounds.size.height+btn.frame.origin.y+5,  btn.bounds.size.width/3-10,btn.bounds.size.height*2+5)];
        btncenter.layer.cornerRadius=15;
        btncenter.backgroundColor=[UIColor colorWithRed:48/255.0 green:122/255.0 blue:205/255.0 alpha:1];
        [vie addSubview:btncenter];
        UIButton *btnbotmom=[[UIButton alloc]initWithFrame:CGRectMake(_margin+btn.bounds.size.width*1/3,btncenter.bounds.size.height+btncenter.frame.origin.y+5,  btn.bounds.size.width/3,btn.bounds.size.height)];
        btnbotmom.layer.cornerRadius=15;
        btnbotmom.backgroundColor=[UIColor greenColor];
        [vie addSubview:btnbotmom];
    

    
}
#pragma mark-地暖制热触发的事件
-(void)heatclik:(UIButton *)btn
{
    btn.backgroundColor=[UIColor colorWithRed:170/255.0  green:103/255.0 blue:47/255.0 alpha:1];
    

}
#pragma mark- 情景模式
-(void)createModes:(UIView *)subviews andars:(NSArray *)appsar andstr:(NSArray *)arsstr
{
    int totalloc=3;
    CGFloat appvieww=(subviews.frame.size.width*0.25)/2;
    CGFloat appviewh=(appvieww+20)/2;
    CGFloat margin=(subviews.frame.size.width-totalloc*appvieww)/(totalloc+1);
    int count=(int)appsar.count;
//    NSLog(@"====%d",count);
    for (int i=0; i<count; i++)
    {
        int row=i/totalloc;//行号
        //1/3=0,2/3=0,3/3=1;
        int loc=i%totalloc;//列号
        CGFloat appviewx=margin+(margin+appvieww)*loc;
        CGFloat appviewy=margin+(margin+appviewh)*row-40;
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
             make.top.equalTo(subviews).with.offset(appviewy);
         }];
        
        //创建uiview控件中的子视图
        UIButton *appimageview=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, appvieww, appvieww)];
        //        appimageview.tag=i;
        appview.tag=i;
        appimageview.tag=i+1;
        UIImage *appimage=[UIImage imageNamed:appsar[i]];
        [appimageview setBackgroundImage:appimage forState:UIControlStateNormal];
//        appimageview.image=appimage;
        [appimageview setContentMode:UIViewContentModeScaleAspectFit];
        [appview addSubview:appimageview];
        //创建文本标签
        UILabel *applable=[[UILabel alloc]initWithFrame:CGRectMake(0, appvieww, appvieww, 20)];
        //        applable.tag=2;
        applable.textColor=[UIColor whiteColor];
        [applable setText:arsstr[i]];
        [applable setTextAlignment:NSTextAlignmentCenter];
        [applable setFont:[UIFont systemFontOfSize:12.0]];
        [appview addSubview:applable];
        //让图片做出响应
        [appimageview addTarget:self action:@selector(onClickImagess:) forControlEvents:UIControlEventTouchUpInside];
//        appview.userInteractionEnabled=YES;
//        //点击图片
//        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImagess:)];
//        [appview addGestureRecognizer:singleTap];
        //长按图片
        
    }
}
#pragma mark- 情景模式
-(void)createMode:(UIView *)subviews andars:(NSArray *)appsar andstr:(NSArray *)arsstr
{
    for(UIView *view in [subviews subviews])
    {
        [view removeFromSuperview];
        
    }
    int totalloc=3;
    CGFloat appvieww=(subviews.frame.size.width*0.25)/2;
    CGFloat appviewh=(appvieww+20)/2;
    CGFloat margin=(subviews.frame.size.width-totalloc*appvieww)/(totalloc+1);
    int count=(int)appsar.count;
    for (int i=0; i<count; i++)
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
             make.top.equalTo(subviews).with.offset(appviewy);
         }];
        
        //创建uiview控件中的子视图
        UIButton *appimageview=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, appvieww, appvieww)];
        //        appimageview.tag=i;
        appview.tag=i;
        appimageview.tag=i+1;
        
        UIImage *appimage=[UIImage imageNamed:appsar[i]];
        [appimageview setBackgroundImage:appimage forState:UIControlStateNormal];
//        appimageview.image=appimage;
        [appimageview setContentMode:UIViewContentModeScaleAspectFit];
        [appview addSubview:appimageview];
        //创建文本标签
        UILabel *applable=[[UILabel alloc]initWithFrame:CGRectMake(0, appvieww, appvieww, 20)];
        //        applable.tag=2;
        applable.textColor=[UIColor whiteColor];
        [applable setText:arsstr[i]];
        [applable setTextAlignment:NSTextAlignmentCenter];
        [applable setFont:[UIFont systemFontOfSize:12.0]];
        [appview addSubview:applable];
        //让图片做出响应
        [appimageview addTarget:self action:@selector(onClickImages:) forControlEvents:UIControlEventTouchUpInside];
//        appview.userInteractionEnabled=YES;
//        //点击图片
//        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImages:)];
//        [appview addGestureRecognizer:singleTap];
        //长按图片
        
    }
}
#pragma mark-情景模式单击图片
-(void)onClickImages:(UIButton *)tap
{
    UIView *vie=[tap superview];
    int index=(int)vie.tag;
//    UIButton *imgv=(UIButton *)[vie viewWithTag:index+1];
    NSArray *ars=[[NSArray alloc]initWithObjects:@"情景模式关闭状态-1",@"情景模式关闭状态-2",@"情景模式关闭状态-3",@"情景模式关闭状态-4",@"情景模式关闭状态-5",@"情景模式关闭状态-8",@"情景模式关闭状态-9", nil];
    if (!tap.selected)
    {
        [tap setBackgroundImage:[UIImage imageNamed:ars[index]] forState:UIControlStateSelected];
        
    }else
    {
        [tap setBackgroundImage:[UIImage imageNamed:_ars[index]] forState:UIControlStateNormal];
    }
    tap.selected=!tap.selected;
    

}
#pragma mark-情景模式单击图片
-(void)onClickImagess:(UIButton *)tap
{
    UIView *vie=[tap superview];
    int index=(int)vie.tag;
//    UIButton *imgv=(UIButton *)[vie viewWithTag:index+1];
    NSArray *ars=[[NSArray alloc]initWithObjects:@"离家模式开启状态-1",@"离家模式开启状态-2",@"离家模式开启状态-3",@"离家模式开启状态-4",@"离家模式开启状态-4",@"离家模式开启状态-4",@"离家模式开启状态-4",@"离家模式开启状态-5",@"离家模式开启状态-6",@"离家模式开启状态-7",@"离家模式开启状态-8", nil];
//    imgv.image=[UIImage imageNamed:ars[index]];
    //如果处于关闭状态单击后将处于开启状态
    if (!tap.selected)
    {
        [tap setBackgroundImage:[UIImage imageNamed:ars[index]] forState:UIControlStateSelected];
        
    }else
    {
        [tap setBackgroundImage:[UIImage imageNamed:_liars[index]] forState:UIControlStateNormal];
    }
    tap.selected=!tap.selected;
    
    
}
#pragma mark-电器
- (void)createDianQ:(UIView *)vie andars:(NSArray *)ars andimgvW:(CGFloat)imgvw andimgvh:(CGFloat)imgvh
{
    for(UIView *view in [vie subviews])
    {
        [view removeFromSuperview];
        
    }
    CGFloat imgvDeviceW=imgvw/2;
    CGFloat imgvDeviceh=imgvh/2;
    for (int i=0; i<ars.count; i++)
    {
        UIImageView *imgvDevice=[[UIImageView alloc]initWithFrame:CGRectMake(_margin, (i+1)*imgvDeviceh/4+i*_margin+i*imgvDeviceW, imgvDeviceW, imgvDeviceh)];
        imgvDevice.image=[UIImage imageNamed:ars[i]];
        [vie addSubview:imgvDevice];
        UIImageView *linev=[[UIImageView alloc]initWithFrame:CGRectMake(imgvDevice.frame.origin.x+imgvDevice.frame.size.width+_margin/2, imgvDevice.frame.origin.y+imgvDeviceh/2, self.view.frame.size.width-(imgvDevice.frame.origin.x+imgvDevice.frame.size.width+_margin/2)*2, 2)];
        linev.image=[UIImage imageNamed:@"图标-8"];
        [vie addSubview:linev];

        UIImageView *imgvsSwitch=[[UIImageView alloc]initWithFrame:CGRectMake(linev.frame.size.width+linev.frame.origin.x+_margin/2, (i+1)*imgvDeviceh/8+i*_margin+i*imgvDeviceW+imgvDeviceh/4, 58.5, 30)];
        imgvsSwitch.image=[UIImage imageNamed:@"图标-6"];
        [vie addSubview:imgvsSwitch];
        
        //让图片做出响应
        imgvsSwitch.userInteractionEnabled=YES;
        imgvsSwitch.tag=i;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImageSwitch:)];
        [imgvsSwitch addGestureRecognizer:singleTap];
        //点击图片
        UIPanGestureRecognizer *singlepan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImageSwitchpan:)];
        [imgvsSwitch addGestureRecognizer:singlepan];
    }
}
- (void)bian:(UISwitch*)switchui
{
    if (flag)
    {
        [switchui setThumbTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"电器调节状态－关"]]];
        flag=NO;
    }else
    {
        [switchui setThumbTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"电器调节状态－开"]]];
        flag=YES;
    }
    
    
    
}
#pragma mark-电动床调整界面
#pragma mark-灯光调整界面
#pragma mark_创建表格
-(void)createTableView:(UIView *)vie andindex:(int)indexTag
{
    for(UIView *view in [vie subviews])
    {
        [view removeFromSuperview];
       
    }
//    NSLog(@"%f======%f======",self.navigationController.tabBarController.view.frame.size.height,self.view.frame.size.height);
    _lighttab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, vie.frame.size.width, vie.frame.size.height)];
    [_lighttab setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_lighttab setScrollEnabled:NO];
    _lighttab.backgroundColor=[UIColor grayColor];
    _lighttab.tag=indexTag;
    [vie addSubview:_lighttab];
    _lighttab.delegate=self;
    _lighttab.dataSource=self;
}
/**
 *  设置每一单元格的高度
 *
 *  @param tableView tableView description
 *  @param indexPath indexPath description
 *
 *  @return return value description
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==3)
    {
        return 121;
    }else if (tableView.tag==2)
    {
        return 337;
    }else
    {
        if (indexPath.row<=1)
        {
            return 100;
        }else
        {
            return 238;
        }
    }
    

}
#pragma mark-datasoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag==3)
    {
        return _curtainAr.count;
    }else if (tableView.tag==2)
    {
        return 2;
    }
    return 4;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idstr=@"aCell";
    
    if (tableView.tag==3)
    {
        curtainTableViewCell *slidercell=[tableView dequeueReusableCellWithIdentifier:idstr];
        if (slidercell==nil)
        {
            slidercell=[[[NSBundle mainBundle]loadNibNamed:@"curtainTableViewCell" owner:nil options:nil] lastObject];
            //4.4 实现委托（将B类的对象赋值给A类委托属性）
            //        bcell.delegate=self;
        }
        slidercell.leftimg.image=[UIImage imageNamed:@"窗帘1"];
        slidercell.rightimg.image=[UIImage imageNamed:@"窗帘图标-2"];
        slidercell.markLab.text=[_curtainAr objectAtIndex:indexPath.row];
        CGFloat w= self.view.frame.size.width-240;
        NSLog(@"%d",(int)indexPath.item);
        FGThrowSlider *slider=[[FGThrowSlider alloc]initWithFrame:CGRectMake(120, 45, w, 31) delegate:self leftTrack:[UIColor whiteColor] rightTrack:[UIColor orangeColor] thumb:[UIImage imageNamed:@"滑动按钮"]];
            [slidercell addSubview:slider];
        //根据tag值判断是那一灯泡
        slider.tag=indexPath.row;
       slidercell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return slidercell;
        
    }else if (tableView.tag==2)
    {
        OtherTableViewCell *slidercell=[tableView dequeueReusableCellWithIdentifier:idstr];
        if (slidercell==nil)
        {
            slidercell=[[[NSBundle mainBundle]loadNibNamed:@"OtherTableViewCell" owner:nil options:nil] lastObject];
            //4.4 实现委托（将B类的对象赋值给A类委托属性）
            //        bcell.delegate=self;
        }
        slidercell.leftImgOne.image=[UIImage imageNamed:@"头部图标"];
        slidercell.rightImgOne.image=[UIImage imageNamed:@"头部调节好图标"];
        slidercell.leftImgTwo.image=[UIImage imageNamed:@"头部图标"];
        slidercell.rightImgTwo.image=[UIImage imageNamed:@"脚部调节好图标"];
//#pragma mark-发送消息，接收返归的slider的values
#pragma mark-读取数据 ＝＝那个房间＝＝＝对应的设备＝＝设备的状态＝＝接收返归的slider的values
        NSString *valuestr=[self readeData];

        CGFloat w= self.view.frame.size.width-240;
        for (int i=0; i<2; i++)
        {
            FGThrowSlider *slider=[[FGThrowSlider alloc]initWithFrame:CGRectMake(120, 55*(i+1)+i*31+(i+1)*15, w, 31) delegate:self leftTrack:[UIColor whiteColor] rightTrack:[UIColor blackColor] thumb:[UIImage imageNamed:@"滑动按钮"]];
            slider.tag=i;
            
//            slider.value=[valuestr intValue];
            [slidercell addSubview:slider];
        }
        slidercell.selectionStyle = UITableViewCellSelectionStyleNone;
        return slidercell;
        
    }else
    {
    if (indexPath.row<=1)
    {
        SliderTableViewCell *slidercell=[tableView dequeueReusableCellWithIdentifier:idstr];
        if (slidercell==nil)
        {
            slidercell=[[[NSBundle mainBundle]loadNibNamed:@"SliderTableViewCell" owner:nil options:nil] lastObject];
            //4.4 实现委托（将B类的对象赋值给A类委托属性）
            //        bcell.delegate=self;
        }
        switch (indexPath.row)
        {
            case 0:
                slidercell.bttomImgv.image=[UIImage imageNamed:@"吊灯"];
                break;
            case 1:
                slidercell.bttomImgv.image=[UIImage imageNamed:@"射灯灯"];
                break;
            default:
                break;
        }
        slidercell.smallImg.image=[UIImage imageNamed:@"灯-1"];
        slidercell.bigImg.image=[UIImage imageNamed:@"灯-2"];
        CGFloat w= self.view.frame.size.width-110-slidercell.bigImg.frame.size.width;
        FGThrowSlider *slider=[[FGThrowSlider alloc]initWithFrame:CGRectMake(65, 25, w, 31) delegate:self leftTrack:[UIColor whiteColor] rightTrack:[UIColor blackColor] thumb:[UIImage imageNamed:@"滑动按钮"]];
        //根据tag值判断是那一灯泡
        slider.tag=indexPath.row;
        [self slider:slider changedValue:slider.value];
        [slidercell addSubview:slider];
        slidercell.selectionStyle = UITableViewCellSelectionStyleNone;
        return slidercell;
    }else
    {
        sconedSliderTableViewCell *slidercell=[tableView dequeueReusableCellWithIdentifier:idstr];
        if (slidercell==nil)
        {
            slidercell=[[[NSBundle mainBundle]loadNibNamed:@"sconedSliderTableViewCell" owner:nil options:nil] lastObject];
            //4.4 实现委托（将B类的对象赋值给A类委托属性）
            //        bcell.delegate=self;
        }
        switch (indexPath.row)
        {
            case 2:
                slidercell.bttomImgv.image=[UIImage imageNamed:@"灯槽上"];
                break;
            case 3:
                slidercell.bttomImgv.image=[UIImage imageNamed:@"灯槽下"];
                break;
            default:
                break;
        }
        
        slidercell.smallImgvOne.image=[UIImage imageNamed:@"灯-1"];
        slidercell.bigImgOne.image=[UIImage imageNamed:@"灯-2"];
        CGFloat w= self.view.frame.size.width-115-slidercell.bigImgOne.frame.size.width;
        for (int i=0; i<3; i++)
        {
            FGThrowSlider *slider=[[FGThrowSlider alloc]initWithFrame:CGRectMake(65, 30*(i+1)+i*31, w, 31) delegate:self leftTrack:[UIColor whiteColor] rightTrack:[UIColor blackColor] thumb:[UIImage imageNamed:@"滑动按钮"]];
            [slidercell addSubview:slider];
        }
        
        slidercell.smallImgvTwo.image=[UIImage imageNamed:@"灯-3"];
        slidercell.bigImgTwo.image=[UIImage imageNamed:@"灯-4"];
        slidercell.smallImgvThere.image=[UIImage imageNamed:@"灯-1"];
        slidercell.bigImgThere.image=[UIImage imageNamed:@"灯-2"];
        slidercell.selectionStyle = UITableViewCellSelectionStyleNone;
        return slidercell;
    }
    }
    return nil;
    

}
/**
 *  实现FGThrowSliderDelegate的方法
 *
 *  @param slider 对应的slider对象，
 *  @param value  value 的变化
 */
-(void)slider:(FGThrowSlider *)slider changedValue:(CGFloat)value
{
#pragma mark-房间＝＝拿台灯＝＝value
    NSString *str=[NSString stringWithFormat:@"home:%@==value%f",@"",value];
    [self write:str];
    
    [_scoketClass cutconnect];
}
/**
 *  点击单元格的时候取消选择单元格
 *
 *  @param tableView tableView description
 *  @param indexPath indexPath description
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setBackgroundColor:[UIColor clearColor]];
    if (tableView.tag>=0)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark-窗帘调整界面
- (void)createCurtainView:(UIView *)vie andars:(NSArray *)ars andimgvw:(CGFloat)imgvw andimgName:(NSString *)imgname andright:(NSString *)rightname
{
    for(UIView *view in [vie subviews])
    {
        [view removeFromSuperview];
        
    }
    CGFloat imgvCurtainw=imgvw;
    CGFloat viemargin=_margin;
    for (int i=0; i<ars.count; i++)
    {
        UIImageView *imgvcurtain=[[UIImageView alloc]initWithFrame:CGRectMake(viemargin, (i+1)*vie.frame.size.height/20+i*viemargin+i*imgvCurtainw, imgvCurtainw, imgvCurtainw)];
        imgvcurtain.image=[UIImage imageNamed:imgname];
        [vie addSubview:imgvcurtain];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(imgvcurtain.center.x-imgvCurtainw/4, imgvcurtain.center.y+imgvCurtainw/3, imgvCurtainw-4.5, (imgvCurtainw-4.5)/2)];
        lab.font=[UIFont boldSystemFontOfSize:14];
        lab.textColor=[UIColor whiteColor];
        lab.text=ars[i];
        [vie addSubview:lab];
        FGThrowSlider *sliderCurtain=[[FGThrowSlider alloc]initWithFrame:CGRectMake(imgvcurtain.frame.origin.x+imgvcurtain.frame.size.width+_margin/2, imgvcurtain.frame.origin.y+imgvCurtainw/2, imgvCurtainw*10, 50)delegate:self leftTrack:[UIColor whiteColor] rightTrack:[UIColor orangeColor] thumb:[UIImage imageNamed:@"滑动按钮"]];
    
        [vie addSubview:sliderCurtain];
        UIImageView *imgvCurtainR=[[UIImageView alloc]initWithFrame:CGRectMake(sliderCurtain.frame.size.width+sliderCurtain.frame.origin.x+viemargin/2, (i+1)*vie.frame.size.height/20+i*viemargin+i*imgvCurtainw, imgvCurtainw, imgvCurtainw)];
        imgvCurtainR.image=[UIImage imageNamed:rightname];
        [vie addSubview:imgvCurtainR];
        
    }

}
#pragma mark-让图片做出响应开与关
- (void)onClickImageSwitchpan:(UIPanGestureRecognizer *)tap
{
        UIView *views=tap.view;
    
        if (_flag==YES)
        {
            _flag=NO;
            //图片关闭
            //
            ((UIImageView *)views).image=[UIImage imageNamed:@"图标-7"];

        }else
        {
            _flag=YES;
            //图片开启
           
            ((UIImageView *)views).image=[UIImage imageNamed:@"图标-6"];

            
        }
   
    

}
#pragma mark-让图片做出响应开与关
- (void)onClickImageSwitch:(UITapGestureRecognizer *)tap
{
    UIView *views=tap.view;
    
    if (_flag==YES)
    {
        _flag=NO;
        //图片关闭
        //
        ((UIImageView *)views).image=[UIImage imageNamed:@"图标-7"];
        
    }else
    {
        _flag=YES;
        //图片开启
        
        ((UIImageView *)views).image=[UIImage imageNamed:@"图标-6"];
        
        
    }
    
    
    
}
#pragma mark-离家模式调整界面
-(void)createHomeView:(UIView *)subviews
{
    NSArray *appsar=[NSArray arrayWithObjects:@"客厅",@"餐厅",@"厨房",@"主卧室",@"女儿房",@"儿子房",@"老人房",@"书房",@"主卫生间",@"次卫生间",@"南阳台",@"北阳台", nil];
    int totalloc=3;
    
    CGFloat appvieww=(subviews.frame.size.width*0.25)/2;
    CGFloat appviewh=(appvieww+20)/2;
    
    CGFloat margin=(subviews.frame.size.width-totalloc*appvieww)/(totalloc+1);
    int count=(int)appsar.count;
    for (int i=0; i<count; i++)
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
             make.top.equalTo(subviews).with.offset(appviewy);
         }];
        
        //创建uiview控件中的子视图
        UIImageView *appimageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, appvieww, appvieww)];
        //        appimageview.tag=i;
        appview.tag=i;
        appimageview.tag=i+1;
        UIImage *appimage=[UIImage imageNamed:appsar[i]];
        appimageview.image=appimage;
        [appimageview setContentMode:UIViewContentModeScaleAspectFit];
        [appview addSubview:appimageview];
        //创建文本标签
        UILabel *applable=[[UILabel alloc]initWithFrame:CGRectMake(0, appvieww, appvieww, 20)];
        //        applable.tag=2;
        applable.textColor=[UIColor whiteColor];
        [applable setText:appsar[i]];
        [applable setTextAlignment:NSTextAlignmentCenter];
        [applable setFont:[UIFont systemFontOfSize:12.0]];
        [appview addSubview:applable];
        //让图片做出响应
        appview.userInteractionEnabled=YES;
        //点击图片
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
        [appview addGestureRecognizer:singleTap];
        //长按图片
        //实例化长按手势监听
        UILongPressGestureRecognizer *longPress =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handleTableviewCellLongPressed:)];
        //代理
        //        longPress.delegate = vctl;
        longPress.minimumPressDuration = 1.0;
        //        将长按手势添加到需要实现长按操作的视图里
        [appview addGestureRecognizer:longPress];
        
        
    }
   
}
#pragma mark-音乐调整界面
- (void)createMusicView:(UIView *)vie
{
    for(UIView *view in [vie subviews])
    {
        [view removeFromSuperview];
        
    }
    vie.backgroundColor=[UIColor whiteColor];
    CGFloat VoiceImgW=10.5;
    CGFloat VoiceImgH=15;
    UIImageView *voiceLeft=[[UIImageView alloc]initWithFrame:CGRectMake(_margin*2, _XiaScv.frame.size.height/2, VoiceImgW, VoiceImgH)];
    voiceLeft.image=[UIImage imageNamed:@"按键-9y"];
    [vie addSubview:voiceLeft];
    UISlider *musicProgress=[[UISlider alloc]initWithFrame:CGRectMake(voiceLeft.frame.origin.x+VoiceImgW+_margin/2, voiceLeft.frame.origin.y+voiceLeft.frame.size.height/2, self.view.bounds.size.width-(voiceLeft.frame.origin.x+VoiceImgW+_margin/2)*2, 8)];
    musicProgress.minimumTrackTintColor=[UIColor blueColor];
    musicProgress.maximumTrackTintColor=[UIColor grayColor];
    [musicProgress setThumbImage:[UIImage imageNamed:@"按键-13y"] forState:UIControlStateNormal];
    [vie addSubview:musicProgress];
    UIImageView *voiceR=[[UIImageView alloc]initWithFrame:CGRectMake(musicProgress.frame.origin.x+musicProgress.frame.size.width+_margin/2, _XiaScv.frame.size.height/2, 24, 24)];
    voiceR.image=[UIImage imageNamed:@"按键-10y"];
    [vie addSubview:voiceR];
    UISlider *Progress=[[UISlider alloc]initWithFrame:CGRectMake(0, voiceR.frame.origin.y+voiceR.frame.size.width+30, self.view.bounds.size.width, 4)];
    Progress.minimumTrackTintColor=[UIColor blueColor];
   
    Progress.maximumTrackTintColor=[UIColor grayColor];
    
    [Progress setThumbImage:[UIImage imageNamed:@"按键-6y"] forState:UIControlStateNormal];
    [vie addSubview:Progress];
    CGFloat imgvw=24.5;
    CGFloat imgvh=25;
    for (int i=0; i<5; i++)
    {
        UIImageView *imgv=[[UIImageView alloc]init];
        if (i==0)
        {
            imgv.frame=CGRectMake(self.view.center.x-43-_margin*2, Progress.frame.origin.y+44, imgvw, imgvh);
           imgv.image=[UIImage imageNamed:[NSString stringWithFormat:@"按键-2y"]];
        }else if(i==1)
        {
           
            imgv.frame=CGRectMake(self.view.center.x-43, Progress.frame.origin.y+14, 85, 85);
            imgv.image=[UIImage imageNamed:[NSString stringWithFormat:@"按键-5y.png"]];
            //让图片做出响应
            imgv.userInteractionEnabled=YES;
            //点击图片
            UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageClick:)];
            [imgv addGestureRecognizer:singleTap];
        }else if(i==2)
        {
            imgv.frame=CGRectMake(self.view.center.x+23+_margin*2, Progress.frame.origin.y+44, imgvw, imgvh);
            imgv.image=[UIImage imageNamed:[NSString stringWithFormat:@"按键-3y"]];
        }else if(i==3)
        {
            imgv.frame=CGRectMake(_margin, Progress.frame.origin.y+94, 32, 17);
            imgv.image=[UIImage imageNamed:[NSString stringWithFormat:@"按键-1y"]];
        
        }else
        {
            imgv.frame=CGRectMake(self.view.frame.size.width-_margin*2, Progress.frame.origin.y+94, 32, 17);
            imgv.image=[UIImage imageNamed:[NSString stringWithFormat:@"按键-4y"]];
        }
        [vie addSubview:imgv];
        
    }
    
}
#pragma mark-音乐图片的点击事件
-(void)ImageClick:(UITapGestureRecognizer *)tap
{
    UIView *views=tap.view;
     UIImageView *imgvs=(UIImageView *)views;
    if (_flag==YES)
    {
        _flag=NO;
        
    imgvs.image=[UIImage imageNamed:@"按键-14y"];
    NSLog(@"%ld",(long)views.tag);
    }else
    {
        _flag=YES;
       
        imgvs.image=[UIImage imageNamed:@"按键-5y"];

    }
}
#pragma mark-在视图滚动过程中持续调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
#pragma mark-在视图滚动结束时调用一次
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index=scrollView.contentOffset.x/(imgvW+_margin);
    float index2=scrollView.contentOffset.x/(imgvW+_margin);
    if (scrollView.tag==1)
    {
       
        if (index2-index>=0)
        {
            [UIView animateWithDuration:0.2 animations:^{
                scrollView.contentOffset=CGPointMake(index*(_margin+imgvW), 0);
                ((UIImageView *)scrollView.subviews[index]).image=[UIImage imageNamed:[NSString stringWithFormat:@"%@1",_subsar[index]]];
            }];
        }
        
        for (int i=0; i<_subsar.count; i++)
        {
            if (i!=index) {
                ((UIImageView *)scrollView.subviews[i]).image=[UIImage imageNamed:[NSString stringWithFormat:@"%@00",_subsar[i]]];
            }
        }

        _XiaScv.contentOffset=CGPointMake(index*self.view.frame.size.width, 0);
        
        CGPoint points=scrollView.contentOffset;

    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            scr.contentOffset=CGPointMake(scrollView.contentOffset.x/320*(_margin+imgvW), 0);
            ((UIImageView *)scrollView.subviews[index]).image=[UIImage imageNamed:[NSString stringWithFormat:@"%@00",_subsar[index]]];
        }];
    }
    
}
#pragma mark-在视图拖拽时调用一次
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
//    NSLog(@"scrollViewDidEndDragging");
    int index=scrollView.contentOffset.x/(imgvW+_margin);
    float index2=scrollView.contentOffset.x/(imgvW+_margin);
    if (scrollView.tag==1) {
        
        if (index2-index>=0)
        {
            [UIView animateWithDuration:0.2 animations:^{
                scrollView.contentOffset=CGPointMake(index*(_margin+imgvW), 0);
                ((UIImageView *)scrollView.subviews[index]).image=[UIImage imageNamed:[NSString stringWithFormat:@"%@1",_subsar[index]]];
            }];
        }
        
        for (int i=0; i<_subsar.count; i++)
        {
            if (i!=index) {
                ((UIImageView *)scrollView.subviews[i]).image=[UIImage imageNamed:[NSString stringWithFormat:@"%@00",_subsar[i]]];
            }
        }

        _XiaScv.contentOffset=CGPointMake(index*self.view.frame.size.width, 0);
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            scr.contentOffset=CGPointMake(scrollView.contentOffset.x/320*(_margin+imgvW), 0);
            ((UIImageView *)scrollView.subviews[index]).image=[UIImage imageNamed:[NSString stringWithFormat:@"%@00",_subsar[index]]];
        }];
    }
}
@end
