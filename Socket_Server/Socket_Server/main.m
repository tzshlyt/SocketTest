//
//  main.m
//  Socket_Server
//
//  Created by lan on 16/8/24.
//  Copyright © 2016年 lan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerSocket.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Socket Server......");
        
        ServerSocket *serverSocket = [[ServerSocket alloc] init];
        [serverSocket run];
        
    }
    return 0;
}
