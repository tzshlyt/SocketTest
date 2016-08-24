//
//  ClientSocket.m
//  Socket_Client
//
//  Created by lan on 16/8/24.
//  Copyright © 2016年 lan. All rights reserved.
//

#import "ClientSocket.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

#define MYPOET 8887
#define BUFFER_SIZE 1024


@interface ClientSocket ()

@property (nonatomic, assign) int socket;

@end

@implementation ClientSocket


- (void)request {
    
    struct sockaddr_in servaddr;
    
    // 1、创建 socket
    if( (self.socket = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        NSLog(@"create socket error: %s(errno: %d)", strerror(errno), errno);
        return;
    }
    
    // 2、连接服务器
    memset(&servaddr, 0, sizeof(servaddr));  // 每个字节都用 0 填充
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(MYPOET);
    servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    if (connect(self.socket, (struct sockaddr *)&servaddr, sizeof(servaddr)) < 0) {
        NSLog(@"connect error: %s(errno: %d)", strerror(errno), errno);
        return;
    }
    
    // 3、发送数据
    char sendBuff[BUFFER_SIZE] = "\nhello \nfirst connect \nend\n";
    send(self.socket, &sendBuff, strlen(sendBuff), 0);
    
    // 4、关闭socket
    close(self.socket);
}

@end
