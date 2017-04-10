//
//  socketManager.h
//  websocket
//
//  Created by 黄家树 on 2017/4/6.
//  Copyright © 2017年 huangjiashu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SRWebSocket.h>

@interface socketManager : NSObject<SRWebSocketDelegate>

@property (nonatomic ,strong)SRWebSocket *webSocket;
@property (nonatomic, assign)NSInteger maxCountTry;

/**
 请求指定网址打开socket

 @param url 建立sokect的网址 socket一般以sw://开头
 */
-(void)socketOpenWithUrl:(NSURL *)url;

/**
 打开socket
 */
-(void)webSocketOpen;

/**
 关闭socket
 */
-(void)webSocketClose;

@end
