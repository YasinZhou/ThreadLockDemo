//
//  atomicControl.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "atomicControl.h"


@interface atomicControl ()
@property (atomic, strong)NSMutableArray *imageNames;
@end

@implementation atomicControl

- (void)getIamgeName{
    NSString *imageName;
    if (self.imageNames.count>0) {
        //原子属性的数据并不是线程安全的，这里会出现内存问题
        imageName = [self.imageNames firstObject];
        [self.imageNames removeObjectAtIndex:0];
    }
    
}

- (void)getImageNameWithMultiThread{
    self.imageNames = [NSMutableArray new];
    int count = 1024*10;
    for (int i=0; i<count; i++) {
        [self.imageNames addObject:[NSString stringWithFormat:@"%d",i]];
    }
    dispatch_group_t dispatchGroup = dispatch_group_create();
    __block double then, now;
    then = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<count+100; i++) {
        //100来测试锁有没有正确的执行
        dispatch_group_async(dispatchGroup, self.synchronizationQueue, ^(){
            [self getIamgeName];
        });
    }
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        now = CFAbsoluteTimeGetCurrent();
        printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,self.imageNames.count);
    });
    
}
@end