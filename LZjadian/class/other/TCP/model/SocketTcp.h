//
//  SocketTcp.h
//  LZjadian
//
//  Created by 张 荣桂 on 16/4/26.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
@interface SocketTcp : NSObject
@property(strong,nonatomic)NSString *readeData;
#pragma mark-建立连接
-(BOOL)connectSocket;
#pragma mark-发送数据
-(void)sendMeg:(NSString *)megstr;
#pragma mark-断开连接
- (void)cutconnect;
@end
