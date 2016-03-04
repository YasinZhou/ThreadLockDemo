//
//  dispatch_barrier_syncControl.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "dispatch_barrier_syncControl.h"
@interface dispatch_barrier_syncControl ()
{
    __block double then, now;
}
@end
@implementation dispatch_barrier_syncControl
- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
    }else{
        now = CFAbsoluteTimeGetCurrent();
        printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNames.count);
    }
}

- (void)getImageNameWithMultiThread{
    NSMutableArray *imageNames = [NSMutableArray new];
    int count = 1024*11;
    for (int i=0; i<count; i++) {
        [imageNames addObject:[NSString stringWithFormat:@"%d",i]];
    }
    then = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<count+1; i++) {
        //100来测试锁有没有正确的执行
        dispatch_barrier_sync(self.synchronizationQueue, ^{
            [self getIamgeName:imageNames];
        });
    }
}
@end
