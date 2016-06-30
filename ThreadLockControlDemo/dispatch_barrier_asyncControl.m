//
//  dispatch_barrier_asyncControl.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "dispatch_barrier_asyncControl.h"

@implementation dispatch_barrier_asyncControl


- (void)getIamgeName{
    while (true) {
        NSString *imageName;
        if (imageNameArray.count>0) {
            imageName = [imageNameArray firstObject];
            [imageNameArray removeObjectAtIndex:0];
        } else {
            now = CFAbsoluteTimeGetCurrent();
            printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
            break;
        }
    }
    
}

- (void)getImageNameWithMultiThread{
    printf("开始删除数组\n");
    then = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<3; i++) {
        //创建三个异步线程，测试锁有没有正确的执行
        dispatch_barrier_async(self.synchronizationQueue, ^{
            [self getIamgeName];
        });
    }
    
}

@end
