//
//  updateViewController.m
//  LZjadian
//
//  Created by 张 荣桂 on 16/4/12.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "updateViewController.h"

@interface updateViewController ()

@end

@implementation updateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameed.text=_nameeds;
    NSLog(@"%@",_nameeds);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)getNewname:(NSString *)named
{
    
}
#pragma mark-修改
- (IBAction)updatebtn:(UIButton *)sender
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getNewname:)])
    {
        [self.delegate getNewname:self.newname.text];
    }
   //    self.newname.text
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
