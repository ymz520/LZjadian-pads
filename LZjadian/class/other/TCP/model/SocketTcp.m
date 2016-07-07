//
//  SocketTcp.m
//  LZjadian
//
//  Created by 张 荣桂 on 16/4/26.
//  Copyright © 2016年 张 荣桂. All rights reserved.
//

#import "SocketTcp.h"
@interface SocketTcp ()<NSStreamDelegate,GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *_asyncSocket;
    
}
@end
@implementation SocketTcp
#pragma mark-建立连接
-(BOOL)connectSocket
{
    
    //主机／端口号
    NSString *host=@"192.168.1.66";
    int port=6666;
    //创建对象
    _asyncSocket=[[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    //建立连接
    NSError *error=nil;
  return   [_asyncSocket connectToHost:host onPort:port error:&error];
    
}
#pragma mark-连接成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"%s",__func__);
    //手动调用读取数据
//    [sock readDataWithTimeout:-1 tag:102];
    
}
#pragma mark_读取数据

#pragma mark-断开连接
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    if(err==nil)
    {
        NSLog(@"正常断开连接");
    }else
    {
        NSLog(@"非正常连接");
    }
    
}
#pragma mark-断开连接
- (void)cutconnect
{
    
    [_asyncSocket disconnect];
}
#pragma mark-发送数据
-(void)sendMeg:(NSString *)megstr
{
    [_asyncSocket writeData:[megstr dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:101];
    [self socket:_asyncSocket didWriteDataWithTag:101];
}
#pragma mark-发送数据成功
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"发送数据成功%s",__func__);
    //手动调用读取数据
    [sock readDataWithTimeout:-1 tag:102];
    [self socket:_asyncSocket didReadData:nil withTag:102];
}

#pragma mark-读取数据成功
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    _readeData=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"====%s,%@====",__func__,_readeData);
}

@end
