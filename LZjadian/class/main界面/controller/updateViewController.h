//
//  updateViewController.h
//  LZjadian
//
//  Created by 张 荣桂 on 16/4/12.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol passingValueDelegate<NSObject>
-(void)getNewname:(NSString *)named;
@end
@interface updateViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameed;
@property (weak, nonatomic) IBOutlet UITextField *newname;
- (IBAction)updatebtn:(UIButton *)sender;
@property(strong,nonatomic)NSString *nameeds;
@property(assign,nonatomic)id <passingValueDelegate> delegate;
@end
