//
//  ServerSocket.m
//  Socket_Server
//
//  Created by lan on 16/8/24.
//  Copyright © 2016年 lan. All rights reserved.
//

#import "ServerSocket.h"
#import <sys/socket.h>
#import <sys/types.h>
#import <netinet/in.h>

#define MYPOERT 8887
#define QUEUE 20
#define BUFFER_SIZE 1024

@interface ServerSocket ()

@property (nonatomic, assign) int socket;

@end


@implementation ServerSocket

- (void)run {
    
    struct sockaddr_in serveraddr;
    char buffer[BUFFER_SIZE];
    int connfd;
    long n;

    /** 1、创建socket描述符，唯一标识一个socket
     *
     *  三个参数分别是
     *       domain: 协议族
     *       type: socket类型
     *       protocol: 协议
     */
    if( (self.socket = socket(AF_INET, SOCK_STREAM, 0)) == -1) { // ipv4,TCP
        NSLog(@"create socket error: %s(errno: %d)", strerror(errno), errno);
        return;
    }
    
    /** 2、把一个地址族中特定的地址赋给socket
     *
     *  三个参数分别是：
     *      sockfd: socket描述字
     *      addr: const struct sockaddr *指针,指向要绑定的sockfd的协议地址，根据协议族不同而不同
     *      addrlen: 对应地址的长度
     */
    memset(&serveraddr, 0, sizeof(serveraddr));  // 每个字节都用 0 填充
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);
    serveraddr.sin_port = htons(MYPOERT);
    
    if (bind(self.socket, (struct sockaddr *)&serveraddr, sizeof(serveraddr)) == -1) {
        NSLog(@"bind socket error: %s(errno: %d)", strerror(errno), errno);
        return;
    }
    
    /** 3、监听socket
     *  两个参数分别是
     *      sockfd: socket描述字
     *      backlog:  socket可以排队的最大连接数
     */
    listen(self.socket, QUEUE);
    
    
    while(1) {
    /** 4、接收请求
     *  三个参数分别是
     *      sockfd: socket描述字
     *      restrict: stuct sockaddr *指针,返回客户端协议地址
     *      addrlen: 协议地址的长度
     */
        if ( (connfd = accept(self.socket, (struct sockaddr *)NULL, NULL)) == -1 ) {
            NSLog(@"accept socket error: %s(errno: %d)", strerror(errno), errno);
        }
        
        /** 5、建立连接后，调用网络I/O进行读写操作
         *  三个参数分别是
         *      sockfd: accept函数返回的已经连接的socket描述字，每个连接一个描述字
         *      buf:  缓存
         *      len:  缓存大小
         *      flages:  
         *  返回接收到的字节数
         */
        n = recv(connfd, buffer, BUFFER_SIZE, 0);
        buffer[n] = '\n';
        
        NSLog(@"recv msg from client: %s\n", buffer);
        close(connfd);
    }
    
    /**
     *  6、关闭socket
     */
    close(self.socket);
    
}

@end
