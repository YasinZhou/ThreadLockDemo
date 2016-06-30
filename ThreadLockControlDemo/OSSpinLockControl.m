//
//  OSSpinLockControl.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "OSSpinLockControl.h"
#import <libkern/OSAtomic.h>
@interface OSSpinLockControl ()
{
    OSSpinLock spinlock;
}
@end

@implementation OSSpinLockControl

-(instancetype)init{
    self = [super init];
    if (self) {
        spinlock = OS_SPINLOCK_INIT;
        /**
         *  初始化
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
        OSSpinLockLock(&spinlock);
        if (imageNameArray.count>0) {
            imageName = [imageNameArray firstObject];
            [imageNameArray removeObjectAtIndex:0];
        } else {
            now = CFAbsoluteTimeGetCurrent();
            printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
            OSSpinLockUnlock(&spinlock);
            return;
        }
        /**
         *  解锁
         */
        OSSpinLockUnlock(&spinlock);
    }
    
}

@end