//
//  socketManager.m
//  websocket
//
//  Created by 黄家树 on 2017/4/6.
//  Copyright © 2017年 huangjiashu. All rights reserved.
//

#import "socketManager.h"



@implementation socketManager{
    NSURL *_url;
    NSInteger _cout;
}


-(SRWebSocket *)webSocket{
    if (!_webSocket) {
//        NSString *urserID ;
//        NSString *deviceToken;//注册远程通知才能拿到token
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"ws://www.id-bear.com/socket/register?userId=%@&imie=%@&type=2",urserID,deviceToken]];
        NSURLRequest *request = [NSURLRequest requestWithURL:_url];//注意先给URL赋值 在执行这个方法
        _webSocket = [[SRWebSocket alloc]initWithURLRequest:request];
        _webSocket.delegate = self;
    }
    return _webSocket;
}

-(void)socketOpenWithUrl:(NSURL *)url{
    _url = url;
    [self.webSocket open];
}

/**
 打开socket
 */
-(void)webSocketOpen{
    [self.webSocket open];
}


/**
 关闭socket
 */
-(void)webSocketClose{
    [self.webSocket close];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    //收到消息
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    //SOKET已经打开
    //1.如果有socket失败计数的在这里归零
    //2.如果没有devicetoken,上传devicetoken
    
    _cout = 0;
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    //失败计数,并在此请求打开socket
    _cout++;
    if (_cout >= _maxCountTry) {
        _cout = _maxCountTry;
    }
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    //链接关闭,可以15s后重新加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webSocket open];
    });
}
@end
