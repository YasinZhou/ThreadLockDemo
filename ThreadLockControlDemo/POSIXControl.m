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
- (void)getIamgeName{
    while (true) {
        NSString *imageName;
        /**
         *  加锁
         */
        pthread_mutex_lock(&mutex);
        if (imageNameArray.count>0) {
            imageName = [imageNameArray firstObject];
            [imageNameArray removeObjectAtIndex:0];
        } else {
            now = CFAbsoluteTimeGetCurrent();
            printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
            pthread_mutex_unlock(&mutex);
            return;
        }
        /**
         *  解锁
         */
        pthread_mutex_unlock(&mutex);
    }
    
}

@end