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
    while (true) {
        NSString *imageName;
        if (self.imageNames.count>0) {
            //原子属性的数据并不是线程安全的，这里会出现内存问题
            imageName = [self.imageNames firstObject];
            [self.imageNames removeObjectAtIndex:0];
        } else {
            now = CFAbsoluteTimeGetCurrent();
            printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,self.imageNames.count);
            return;
        }
    }
    
    
}

- (void)getImageNameWithMultiThread{
    
    self.imageNames = [NSMutableArray new];
    int count = 1024*10;
    for (int i=0; i<count; i++) {
        [self.imageNames addObject:[NSString stringWithFormat:@"%d",i]];
    }
    printf("数组初始化话完成-----imageNames count: %ld\n",self.imageNames.count);
    printf("开始删除数组\n");
    then = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<3; i++) {
        //创建三个异步线程，测试锁有没有正确的执行
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
            [self getIamgeName];
        });
    }
    
}
@end