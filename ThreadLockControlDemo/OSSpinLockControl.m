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
- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    /**
     *  加锁
     */
    OSSpinLockLock(&spinlock);
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
    }
    /**
     *  解锁
     */
    OSSpinLockUnlock(&spinlock);
    
}
@end