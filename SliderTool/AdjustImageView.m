//
//  AdjustImageView.m
//  volude_demo
//
//  Created by Mac on 16/4/18.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "AdjustImageView.h"
#import "AdjustModel.h"
#import <MediaPlayer/MediaPlayer.h>


@interface AdjustImageView ()
// 步骤2 在刚刚新建类的`类扩展`中添加子控件属性（用`weak`声明，防止内存泄露）

@property (nonatomic, weak) UISlider *sliderA;

@property (nonatomic, weak) UIImageView *signView;

@end

@implementation AdjustImageView

// 步骤3 在initWithFrame:方法中添加子控件
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.7;
        // 注意：该处不要给子控件设置frame与数据，可以在这里初始化子控件的属性

        UIImageView *signView = [[UIImageView alloc] init];
        self.signView = signView;
        [self addSubview:signView];
        
        
        UISlider *sliderA = [[UISlider alloc] init];
        self.sliderA = sliderA;
    
        
        [self addSubview:sliderA];
        
    }
    return self;
}
// 步骤4 在`layoutSubviews`方法中设置子控件的`frame`（在该方法中一定要调用`[super layoutSubviews]`方法）
- (void)layoutSubviews
{
    [super layoutSubviews];
   
    CGFloat sliderAViewX = 0;
    CGFloat sliderAViewY = 0;
    CGFloat sliderAViewW = self.bounds.size.width;
    CGFloat sliderAViewH = 80;
    self.signView.frame = CGRectMake(sliderAViewW-30, 2, 30, 30);
    self.sliderA.frame = CGRectMake(3, 2, sliderAViewW-30, 30);
    
    self.sliderA.value = 0.5;
    self.sliderA.transform = CGAffineTransformMakeRotation(M_PI);
    self.sliderA.minimumValue=0.0;
    self.sliderA.maximumValue=1.0;
    //滑块拖动时的事件
    [self.sliderA addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
  
  
}

// 步骤6 在该`setter`方法中取出模型属性，给对应的子控件赋值
- (void)setModel:(AdjustModel *)model
{
    _model = model;
    
    self.signView.image = [UIImage imageNamed:model.lowerImg];
    [self.sliderA setMinimumTrackImage:[UIImage imageNamed:model.stetchLeftTrack] forState:UIControlStateNormal];
    [self.sliderA setMaximumTrackImage:[UIImage imageNamed:model.icostetchRightTrackn] forState:UIControlStateNormal];
    [self.sliderA setThumbImage:[UIImage imageNamed:model.thumbImage] forState:UIControlStateNormal];
    [self.sliderA setThumbImage:[UIImage imageNamed:model.thumbImage] forState:UIControlStateHighlighted];

    
}


-(void)sliderValueChanged:(UISlider *)slider{
    MPMusicPlayerController *mp = [MPMusicPlayerController applicationMusicPlayer];
    mp.volume = slider.value;
  //  NSLog(@"%f",slider.value);
    NSLog(@"%f",mp.volume);
    
}

@end
