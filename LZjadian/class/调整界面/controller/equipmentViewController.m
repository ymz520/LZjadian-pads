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
#import "AdjustImageView.h"
#import "AdjustModel.h"
@interface equipmentViewController ()
<UIScrollViewDelegate>
{
    int _pages;
    CGFloat _margin;
    UIScrollView *scr;
    UIScrollView *_XiaScv;
    UIButton *backbtn;
    BOOL _flag;
    NSArray *_ars;
    NSArray *_liars;
    CGFloat imgvW;
}
@end

@implementation equipmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor=[UIColor whiteColor];
    imgvW=self.view.frame.size.width*0.25;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    //创建上滚动视图
    [self createSCRView];
    [UIView animateWithDuration:0.2 animations:^{
        scr.contentOffset=CGPointMake(_tags*(_margin+imgvW), 0);
        _XiaScv.contentOffset=CGPointMake(_tags*self.view.frame.size.width, 0);
    }];
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
        NSLog(@"间距＝%.2f＝%.2f",_pages*imgvW,_margin);
        
    }else
    {
        _pages=((int)self.subsar.count/3)+1;
        int counts=(int)(_subsar.count-(_subsar.count%3));
        _margin=(((_pages-1)*self.view.bounds.size.width)-counts*imgvW)/(counts+1);
        NSLog(@"间距＝＝%.2f",_margin);
    }
    NSLog(@"有几页%d",_pages);
    //有多少列
    int lie=_subsar.count;
    NSLog(@"有多少列%d",lie);
    for (int i=0; i<_subsar.count; i++)
    {
        int loc=i%lie;//列号
        NSLog(@"有/列号%d",loc);
        CGFloat appviewx=_margin+(_margin+imgvW)*loc;
        UIImageView *imageViews=[[UIImageView alloc] initWithFrame:CGRectMake(appviewx, _margin+(_margin+imgvW)*(0%_subsar.count), imgvW/2, imgvW/2)];
        if (i==0)
        {
            imageViews.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@1",_subsar[i]]];
        }
        imageViews.image=[UIImage imageNamed:_subsar[i]];
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
    }];
    
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
//
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
    
    //屏幕适配
//    [_XiaScv mas_makeConstraints:^(MASConstraintMaker *make)
//    {
////         WithFrame:CGRectMake(0, scr.frame.size.height+1, self.view.bounds.size.width, self.view.bounds.size.height*3/4)];
//        make.height.mas_equalTo(self.view.bounds.size.height*3/4-_margin);
//        make.width.mas_equalTo(self.view.bounds.size.width);
//        make.left.equalTo(self.view).with.offset(0);
//        make.top.equalTo(self.view).with.offset(scr.frame.size.height+1);
//    }];
}
#pragma mark-根据数组下标创建不同的视图
-(void)createSubView:(int)index andview:(UIView *)vie
{
    if ([_subsar[index] isEqualToString:@"灯光"])
    {
        //灯光调整界面
        [self createLightView:vie];
    }else if ([_subsar[index] isEqualToString:@"窗帘"])
    {
        CGFloat imgvCurtainw=(vie.frame.size.width-4*_margin)/12;
        NSArray *ars=[[NSArray alloc]initWithObjects:@"窗纱",@"窗帘",@"窗纱",@"窗帘",@"遮光", nil];
        //窗帘调整界面
        [self createCurtainView:vie andars:ars andimgvw:imgvCurtainw andimgName:@"窗帘1.png" andright:@"窗帘图标-2"];
    
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
        CGFloat imgvCurtainw=44.5;
//        NSArray *ars=[[NSArray alloc]initWithObjects:@"头部图标",@"头部调节好脚部图标",@"脚部调节好图标", nil];
        [self createBedView:vie andimgvw:imgvCurtainw];
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
            NSLog(@"%d",row);
            if ((i+1)%2==0)
            {
                btns.frame=CGRectMake(_margin+btn.bounds.size.width*2/3, btn.bounds.size.height+btn.frame.origin.y+(row+1)*5+row*btn.bounds.size.height, btn.bounds.size.width/3, btn.bounds.size.height);
            }else
            {
                
                btns.frame=CGRectMake(_margin, btn.bounds.size.height+btn.frame.origin.y+(row+1)*5+row*btn.bounds.size.height, btn.bounds.size.width/3, btn.bounds.size.height);
            }
            NSLog(@"%.2f===%.2f",btns.frame.origin.x,btns.frame.origin.y);
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
    NSLog(@"====%d",count);
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
        [applable setText:arsstr[i]];
        [applable setTextAlignment:NSTextAlignmentCenter];
        [applable setFont:[UIFont systemFontOfSize:12.0]];
        [appview addSubview:applable];
        //让图片做出响应
        appview.userInteractionEnabled=YES;
        //点击图片
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImagess:)];
        [appview addGestureRecognizer:singleTap];
        //长按图片
        
    }
}
#pragma mark- 情景模式
-(void)createMode:(UIView *)subviews andars:(NSArray *)appsar andstr:(NSArray *)arsstr
{
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
        [applable setText:arsstr[i]];
        [applable setTextAlignment:NSTextAlignmentCenter];
        [applable setFont:[UIFont systemFontOfSize:12.0]];
        [appview addSubview:applable];
        //让图片做出响应
        appview.userInteractionEnabled=YES;
        //点击图片
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImages:)];
        [appview addGestureRecognizer:singleTap];
        //长按图片
        
    }
}
#pragma mark-情景模式单击图片
-(void)onClickImages:(UITapGestureRecognizer *)tap
{
    UIView *vie=tap.view;
    int index=(int)vie.tag;
    UIImageView *imgv=(UIImageView *)[vie viewWithTag:index+1];
    NSArray *ars=[[NSArray alloc]initWithObjects:@"情景模式关闭状态-1",@"情景模式关闭状态-2",@"情景模式关闭状态-3",@"情景模式关闭状态-4",@"情景模式关闭状态-5",@"情景模式关闭状态-8",@"情景模式关闭状态-9", nil];
    imgv.image=[UIImage imageNamed:ars[index]];
    //如果处于关闭状态单击后将处于开启状态
    if(_flag==YES)
    {
        NSLog(@"开启=%@==%hhd",_ars[index],_flag);
        
        //图片关闭
//        [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@关闭",ars[index]]];
        imgv.image=[UIImage imageNamed:ars[index]];
        _flag=NO;
    }else
    {
//        NSLog(@"关闭=%@==%hhd",_subappar[index],isBool);
        
        //图片开启
//        [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@开启",_ars[index]]];
        
        imgv.image=[UIImage imageNamed:_ars[index]];
        _flag=YES;
    }

}
#pragma mark-情景模式单击图片
-(void)onClickImagess:(UITapGestureRecognizer *)tap
{
    UIView *vie=tap.view;
    int index=(int)vie.tag;
    UIImageView *imgv=(UIImageView *)[vie viewWithTag:index+1];
    NSArray *ars=[[NSArray alloc]initWithObjects:@"离家模式开启状态-1",@"离家模式开启状态-2",@"离家模式开启状态-3",@"离家模式开启状态-4",@"离家模式开启状态-4",@"离家模式开启状态-4",@"离家模式开启状态-4",@"离家模式开启状态-5",@"离家模式开启状态-6",@"离家模式开启状态-7",@"离家模式开启状态-8", nil];
    imgv.image=[UIImage imageNamed:ars[index]];
    //如果处于关闭状态单击后将处于开启状态
    if(_flag==YES)
    {
//        NSLog(@"开启=%@==%hhd",_ars[index],_flag);
        
        //图片关闭
        //[MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@关闭",ars[index]]];
        imgv.image=[UIImage imageNamed:ars[index]];
        _flag=NO;
    }else
    {
        //        NSLog(@"关闭=%@==%hhd",_subappar[index],isBool);
        
        //图片开启
//        [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@开启",_liars[index]]];
        
        imgv.image=[UIImage imageNamed:_liars[index]];
        _flag=YES;
    }
    
}
#pragma mark-电器
- (void)createDianQ:(UIView *)vie andars:(NSArray *)ars andimgvW:(CGFloat)imgvw andimgvh:(CGFloat)imgvh
{
    
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
        //点击图片
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImageSwitch:)];
        [imgvsSwitch addGestureRecognizer:singleTap];
    }
}

#pragma mark-灯光调整界面
- (void)createLightView:(UIView *)vie
{
    
    CGFloat imgvSmallw=14;
    CGFloat imgvSmallh=18;
    CGFloat imgvBigw=29;
    CGFloat imgvBigh=43;
    CGFloat lightimgw=vie.frame.size.width;
    CGFloat lighth=10;
    CGFloat _may=_margin/2;
    for (int i=0; i<8; i++)
    {
        
        UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(imgvSmallw, (i+1)*_may+i*imgvBigh+30, imgvSmallw, imgvSmallh)];
        imgv.image=[UIImage imageNamed:@"灯-1"];
        [vie addSubview:imgv];
        CGRect rect=CGRectMake(imgv.frame.origin.x+imgv.frame.size.width+_margin/2, imgv.frame.origin.y+imgvSmallh/2+30, 312, 5);
//        [self createSlider:@"滑动纽" andstetchLeftTrack:@"滑动条-1" andicostetchRightTrackn:@"滑动条-2" andlowerImg:@"灯-2" andframe:rect andview:vie];
        
        UISlider *slider=[UISlider new];
////    initWithFrame:CGRectMake(imgv.frame.origin.x+imgv.frame.size.width+_margin/2, imgv.frame.origin.y+imgvSmallh/2, self.view.frame.size.width-(imgv.frame.origin.x+imgv.frame.size.width+_margin/2)*2, 5)];
        //约束2

        slider.minimumTrackTintColor=[UIColor whiteColor];
        slider.maximumTrackTintColor=[UIColor blackColor];
        [slider setThumbImage:[UIImage imageNamed:@"滑动纽"] forState:UIControlStateNormal];
        slider.tag=i;
        slider.value=arc4random_uniform(100)/100.0;
        [vie addSubview:slider];
        [slider mas_makeConstraints:^(MASConstraintMaker *make)
         {
             
             make.height.mas_equalTo(20);
             make.width.mas_equalTo(self.view.frame.size.width-(imgv.frame.origin.x+imgv.frame.size.width+_margin/2)*2);
             make.left.equalTo(vie).with.offset(imgv.frame.origin.x+imgv.frame.size.width+_margin/3);
             make.top.equalTo(vie).with.offset(imgv.frame.origin.y);
         }];
//        滑块添加事件
//        [slider addTarget:self action:@selector(handleclick:) forControlEvents:UIControlEventValueChanged];
//        [slider addTarget:self action:@selector(handleclicks:) forControlEvents:UIControlEventTouchDown];
//        [slider addTarget:self action:@selector(handleclickss:) forControlEvents:UIControlEventTouchDragOutside];
        UIImageView *imgvBig=[UIImageView new];
//    initWithFrame:CGRectMake(slider.frame.size.width+slider.frame.origin.x+_margin/2, (i+1)*5+i*25+i*imgvSmallh-5, imgvBigw, imgvBigh)];
        imgvBig.image=[UIImage imageNamed:@"灯-2"];
        [vie addSubview:imgvBig];
        [imgvBig mas_makeConstraints:^(MASConstraintMaker *make)
         {
//             imgvSmallw, i*_may+i*imgvSmallh
             make.height.mas_equalTo(imgvBigh);
             make.width.mas_equalTo(imgvBigw);
             make.left.equalTo(vie).with.offset(vie.bounds.size.width-_margin);
//             (i+1)*_may+i*imgvBigh
             make.top.equalTo(vie).with.offset((i+1)*_may+i*imgvBigh+30);
         }];

        UIImageView *imgv1=[[UIImageView alloc]initWithFrame:CGRectMake(0,(i+1)*(imgvBigh+imgvBig.frame.origin.y)+_may/2+30, lightimgw, lighth)];
        if (i==0)
        {
            imgv1.frame=CGRectMake(0,(i+1)*(imgvBigh+imgvBig.frame.origin.y)+_may/2+45, lightimgw, lighth);
            imgv1.image=[UIImage imageNamed:@"吊灯"];
            [vie addSubview:imgv1];
        }else if(i==2)
        {
            imgv1.image=[UIImage imageNamed:@"射灯"];
             [vie addSubview:imgv1];
            
        }else if(i==3||i==5)
        {
            imgv.image=[UIImage imageNamed:@"灯-3"];
            imgvBig.image=[UIImage imageNamed:@"灯-4"];
             [vie addSubview:imgv1];
        }else if(i==6)
        {
            imgv1.frame=CGRectMake(0,(i+1)*(imgvBigh+imgvBig.frame.origin.y)+_may/2+imgvBigh+30, lightimgw, lighth);
            imgv1.image=[UIImage imageNamed:@"灯槽上"];
            [vie addSubview:imgv1];
            
        }else if (i==7)
        {
            imgv1.frame=CGRectMake(0,(i+1)*_may+i*imgvBigh+imgvBigh+30, lightimgw, lighth);
            imgv1.image=[UIImage imageNamed:@"灯槽下"];
            [vie addSubview:imgv1];
        }
      

        
        
    }
}
#pragma mark-创建滑块
-(void)createSlider:(NSString *)modelWithThumnImage andstetchLeftTrack:(NSString *)stetchLeftTrack andicostetchRightTrackn:(NSString *)icostetchRightTrackn andlowerImg:(NSString*)lowerImg andframe:(CGRect)frames andview:(UIView *)vie
{
#pragma 封装后调用
    AdjustImageView *sliderB = [[AdjustImageView alloc] initWithFrame:frames];
    AdjustModel *model = [AdjustModel modelWithThumnImage:modelWithThumnImage stetchLeftTrack:stetchLeftTrack icostetchRightTrackn:icostetchRightTrackn lowerImg:lowerImg];
    sliderB.model = model;
    sliderB.frame = frames;
    sliderB.userInteractionEnabled = YES;
    
    [vie addSubview:sliderB];

}
#pragma mark-响应滑块事件
-(void)handleclick:(UISlider *)slider
{
    //开启tcp通讯
    [MBProgressHUD showSuccess:@"滑动滑块"];
    NSLog(@"%ld",(long)slider.tag);

}
-(void)handleclicks:(UISlider *)slider
{
    //开启tcp通讯
    [MBProgressHUD showSuccess:@"滑动滑块"];
    NSLog(@"%ld",(long)slider.tag);
    
}
-(void)handleclickss:(UISlider *)slider
{
    //开启tcp通讯
    [MBProgressHUD showSuccess:@"滑动滑块"];
    NSLog(@"%ld",(long)slider.tag);
    
}
#pragma mark-电动床调整界面
- (void)createBedView:(UIView *)vie andimgvw:(CGFloat)imgvw
{
    CGFloat imgvCurtainw=imgvw;
    UILabel *lab;
    for (int i=0; i<4; i++)
    {
        
        UIImageView *imgvcurtain=[[UIImageView alloc]initWithFrame:CGRectMake(_margin, (i+1)*10+i*30+i*imgvCurtainw, imgvCurtainw, imgvCurtainw)];
        if(i==0)
        {
            imgvcurtain.image=[UIImage imageNamed:@"头部图标"];
        }else
        {
             imgvcurtain.image=[UIImage imageNamed:@"脚部图标"];
        }
        
        [vie addSubview:imgvcurtain];
        lab=[[UILabel alloc]initWithFrame:CGRectMake(imgvcurtain.center.x-imgvCurtainw/3, imgvcurtain.center.y+imgvCurtainw/3, 40, 40)];
        lab.font=[UIFont boldSystemFontOfSize:14];
        lab.textColor=[UIColor whiteColor];
       
        [vie addSubview:lab];
        UISlider *sliderCurtain=[[UISlider alloc]initWithFrame:CGRectMake(imgvcurtain.frame.origin.x+imgvcurtain.frame.size.width+_margin/2, imgvcurtain.frame.origin.y+imgvCurtainw/2, self.view.frame.size.width-(imgvcurtain.frame.origin.x+imgvcurtain.frame.size.width+_margin/2)*2, 10)];
        sliderCurtain.minimumTrackTintColor=[UIColor orangeColor];
        sliderCurtain.maximumTrackTintColor=[UIColor whiteColor];
        [sliderCurtain setThumbImage:[UIImage imageNamed:@"滑动纽"] forState:UIControlStateNormal];
        [vie addSubview:sliderCurtain];
        UIImageView *imgvCurtainR=[[UIImageView alloc]initWithFrame:CGRectMake(sliderCurtain.frame.size.width+sliderCurtain.frame.origin.x+_margin/2, (i+1)*10+i*30+i*imgvCurtainw, imgvCurtainw, imgvCurtainw)];
        if(i==0)
        {
            lab.text=@"头部";
             imgvCurtainR.image=[UIImage imageNamed:@"头部调节好图标"];
        }else
        {
            lab.text=@"脚部";
            imgvCurtainR.image=[UIImage imageNamed:@"脚部调节好图标"];
        }
       
        [vie addSubview:imgvCurtainR];
        
    }
   NSArray *ars=[[NSArray alloc]initWithObjects:@"左",@"按摩",@"低",@"中",@"高",nil];
       //初始化UISegmentedControl
    	    UISegmentedControl *srgctl = [[UISegmentedControl alloc]initWithItems:ars];
    srgctl.frame=CGRectMake(_margin,lab.frame.origin.y+lab.frame.size.width+10 , vie.frame.size.width-_margin*2, _margin);
    [srgctl setBackgroundColor:[UIColor whiteColor]];
    //控件风格灰边大白按钮，适合偏好设置单元
    srgctl.tintColor = [UIColor colorWithRed:73/255.0 green:154/255.0 blue:131/255.0 alpha:1];
    [vie addSubview:srgctl];

}
#pragma mark-窗帘调整界面
- (void)createCurtainView:(UIView *)vie andars:(NSArray *)ars andimgvw:(CGFloat)imgvw andimgName:(NSString *)imgname andright:(NSString *)rightname
{
    CGFloat imgvCurtainw=imgvw;
    CGFloat viemargin=_margin;
    for (int i=0; i<ars.count; i++)
    {
        UIImageView *imgvcurtain=[[UIImageView alloc]initWithFrame:CGRectMake(viemargin, (i+1)*vie.frame.size.height/20+i*viemargin+i*imgvCurtainw, imgvCurtainw, imgvCurtainw)];
        imgvcurtain.image=[UIImage imageNamed:imgname];
        [vie addSubview:imgvcurtain];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(imgvcurtain.center.x-imgvCurtainw/4, imgvcurtain.center.y+imgvCurtainw/2, imgvCurtainw-4.5, (imgvCurtainw-4.5)/2)];
        lab.font=[UIFont boldSystemFontOfSize:14];
        lab.textColor=[UIColor whiteColor];
        lab.text=ars[i];
        [vie addSubview:lab];
        UISlider *sliderCurtain=[[UISlider alloc]initWithFrame:CGRectMake(imgvcurtain.frame.origin.x+imgvcurtain.frame.size.width+_margin/2, imgvcurtain.frame.origin.y+imgvCurtainw/2, imgvCurtainw*10, 10)];
        sliderCurtain.minimumTrackTintColor=[UIColor orangeColor];
        sliderCurtain.maximumTrackTintColor=[UIColor whiteColor];
        [sliderCurtain setThumbImage:[UIImage imageNamed:@"滑动纽"] forState:UIControlStateNormal];
        [vie addSubview:sliderCurtain];
        UIImageView *imgvCurtainR=[[UIImageView alloc]initWithFrame:CGRectMake(sliderCurtain.frame.size.width+sliderCurtain.frame.origin.x+viemargin/2, (i+1)*vie.frame.size.height/20+i*viemargin+i*imgvCurtainw, imgvCurtainw, imgvCurtainw)];
        imgvCurtainR.image=[UIImage imageNamed:rightname];
        [vie addSubview:imgvCurtainR];
        
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
//        [MBProgressHUD showSuccess:@"关闭"];
        ((UIImageView *)views).image=[UIImage imageNamed:@"图标-7"];
    }else
    {
        _flag=YES;
        //图片开启
//        [MBProgressHUD showSuccess:@"开启"];
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

    vie.backgroundColor=[UIColor whiteColor];
    CGFloat VoiceImgW=10.5;
    CGFloat VoiceImgH=15;
    UIImageView *voiceLeft=[[UIImageView alloc]initWithFrame:CGRectMake(_margin*2, _XiaScv.frame.size.height/2, VoiceImgW, VoiceImgH)];
    voiceLeft.image=[UIImage imageNamed:@"按键-9y"];
    [vie addSubview:voiceLeft];
//    [voiceLeft mas_makeConstraints:^(MASConstraintMaker *make)
//    {
//        //WithFrame:CGRectMake(_margin*2, _XiaScv.frame.size.height/2, VoiceImgW, VoiceImgH)
//        make.height.mas_equalTo(VoiceImgH);
//        make.width.mas_equalTo(VoiceImgW);
//        make.left.equalTo(vie).with.offset(_margin*2);
//        make.top.equalTo(vie).with.offset(vie.frame.size.height/2);
//        
//    }];
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
    if (scrollView.tag==1) {
        int index=scrollView.contentOffset.x/(imgvW+_margin);
        float index2=scrollView.contentOffset.x/(imgvW+_margin);
        if (index2-index>0)
        {
            [UIView animateWithDuration:0.2 animations:^{
                scrollView.contentOffset=CGPointMake(index*(_margin+imgvW), 0);
            }];
        }
        _XiaScv.contentOffset=CGPointMake(index*self.view.frame.size.width, 0);
        
        CGPoint points=scrollView.contentOffset;
        NSLog(@"===x=%.2f===y=%.2f",points.x,points.y);
        NSLog(@"===%ld===",(long)scrollView.tag);
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            scr.contentOffset=CGPointMake(scrollView.contentOffset.x/320*(_margin+imgvW), 0);
        }];
    }
    
}
#pragma mark-在视图拖拽时调用一次
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    NSLog(@"scrollViewDidEndDragging");
    if (scrollView.tag==1) {
        int index=scrollView.contentOffset.x/(imgvW+_margin);
        float index2=scrollView.contentOffset.x/(imgvW+_margin);
        if (index2-index>0)
        {
            [UIView animateWithDuration:0.2 animations:^{
                scrollView.contentOffset=CGPointMake(index*(_margin+imgvW), 0);
                
            }];
        }
        _XiaScv.contentOffset=CGPointMake(index*self.view.frame.size.width, 0);
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            scr.contentOffset=CGPointMake(scrollView.contentOffset.x/320*(_margin+imgvW), 0);
        }];
    }
}
@end
