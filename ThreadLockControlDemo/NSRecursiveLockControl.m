//
//  NSRecursiveLockControl.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "NSRecursiveLockControl.h"

@interface NSRecursiveLockControl ()
{
    NSRecursiveLock *lock;
}
@end
@implementation NSRecursiveLockControl
-(instancetype)init{
    self = [super init];
    if (self) {
        lock = [[NSRecursiveLock alloc]init];
    }
    return self;
}
- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    [lock lock];
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
        [self getIamgeName:imageNames];
        
    }
    [lock unlock];
}
- (void)getImageNameWithMultiThread{

    dispatch_group_t dispatchGroup = dispatch_group_create();
    printf("开始删除数组\n");
    then = CFAbsoluteTimeGetCurrent();
    
    //这里不需要for循环创建线程了
    dispatch_group_async(dispatchGroup, self.synchronizationQueue, ^(){
        [self getIamgeName:imageNameArray];
    });
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        now = CFAbsoluteTimeGetCurrent();
        printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
    });
}
@end