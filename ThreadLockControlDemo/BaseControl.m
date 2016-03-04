//
//  BaseControl.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "BaseControl.h"

@implementation BaseControl
-(instancetype)init{
    self = [super init];
    if (self) {
        _synchronizationQueue = dispatch_queue_create([@"com.yasin.synchronization" cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}
- (void)getIamgeName:(NSMutableArray *)imageNames{//假如每个进来的都是一个线程
    //1.imageNames是线程外的变量，这个时候就需要考虑线程安全
    /*2.NSMutableArray *array = [[NSMutableArray alloc]initWithArray:imageNames];
     这里如果新生成一个array，下面也把imageNames换成array就不需要考虑线程安全，但是这样array.count判断永远大于0，也就是永远等于imageNames.count-1
     */
    NSString *imageName;
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
    }
}
#pragma mark - 多线程取出图片后删除
- (void)getImageNameWithMultiThread{
    NSMutableArray *imageNames = [NSMutableArray new];
    int count = 1024*10;
    for (int i=0; i<count; i++) {
        [imageNames addObject:[NSString stringWithFormat:@"%d",i]];
    }
    dispatch_group_t dispatchGroup = dispatch_group_create();
    __block double then, now;
    then = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<count+100; i++) {
        //100来测试锁有没有正确的执行
        dispatch_group_async(dispatchGroup, self.synchronizationQueue, ^(){
            [self getIamgeName:imageNames];
        });
    }
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        now = CFAbsoluteTimeGetCurrent();
        printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNames.count);
    });
    
}
@end
