//
//  main.m
//  Socket_Client
//
//  Created by lan on 16/8/24.
//  Copyright © 2016年 lan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClientSocket.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Client Socket......");
        
        ClientSocket *clientSocket = [[ClientSocket alloc] init];
        [clientSocket request];
        
    }
    return 0;
}
