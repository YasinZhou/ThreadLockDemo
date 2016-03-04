//
//  DispatchSemaphoreControl.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "DispatchSemaphoreControl.h"


@interface DispatchSemaphoreControl ()
{
    dispatch_semaphore_t semaphore;
}
@end
@implementation DispatchSemaphoreControl
-(instancetype)init{
    self = [super init];
    if (self) {
        semaphore = dispatch_semaphore_create(1);
        /**
         *  创建一个信号量为1的信号
         *
         */
    }
    return self;
}
- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    /**
     *  semaphore：等待信号
     DISPATCH_TIME_FOREVER：等待时间
     wait之后信号量-1，为0
     */
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
    }
    /**
     *  发送一个信号通知，这时候信号量+1，为1
     */
    dispatch_semaphore_signal(semaphore);
}
@end