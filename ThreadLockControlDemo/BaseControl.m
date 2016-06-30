//
//  BaseControl.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "BaseControl.h"
@interface BaseControl()

@end
@implementation BaseControl
-(instancetype)init{
    self = [super init];
    if (self) {
        _synchronizationQueue = dispatch_queue_create([@"com.yasin.synchronization" cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_CONCURRENT);
        
        imageNameArray = [NSMutableArray new];
        int count = 1024*10;
        for (int i=0; i<count; i++) {
            [imageNameArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        printf("数组初始化话完成-----imageNames count: %ld\n",imageNameArray.count);
    }
    return self;
}

- (void)getIamgeName{//假如每个进来的都是一个线程
    //1.imageNames是线程外的变量，这个时候就需要考虑线程安全
    /*2.NSMutableArray *array = [[NSMutableArray alloc]initWithArray:imageNames];
     这里如果新生成一个array，下面也把imageNames换成array就不需要考虑线程安全，但是这样array.count判断永远大于0，也就是永远等于imageNames.count-1
     */
    while (true) {
        NSString *imageName;
        if (imageNameArray.count>0) {
            imageName = [imageNameArray firstObject];
            [imageNameArray removeObjectAtIndex:0];
        } else {
            now = CFAbsoluteTimeGetCurrent();
            printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
            return;
        }
    }
    
}
#pragma mark - 多线程取出图片后删除
- (void)getImageNameWithMultiThread{
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
