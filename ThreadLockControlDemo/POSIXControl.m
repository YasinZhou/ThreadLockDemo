//
//  POSIXControl.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "POSIXControl.h"
#import <pthread.h>
@interface POSIXControl ()
{
    pthread_mutex_t mutex;  //声明pthread_mutex_t的结构
}
@end

@implementation POSIXControl
- (void)dealloc{
    pthread_mutex_destroy(&mutex);  //释放该锁的数据结构
}
-(instancetype)init{
    self = [super init];
    if (self) {
        pthread_mutex_init(&mutex, NULL);
        /**
         *  初始化互斥锁
         *
         */
    }
    return self;
}
- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    /**
     *  加锁
     */
    pthread_mutex_lock(&mutex);
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
    }
    /**
     *  解锁
     */
    pthread_mutex_unlock(&mutex);
    
}
@end