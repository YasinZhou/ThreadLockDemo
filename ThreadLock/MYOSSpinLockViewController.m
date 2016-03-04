//
//  MYOSSpinLockViewController.m
//  ThreadLock
//
//  Created by Yasin on 16/3/3.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "MYOSSpinLockViewController.h"
#import <libkern/OSAtomic.h>
@interface MYOSSpinLockViewController ()
{
    OSSpinLock spinlock;  //声明pthread_mutex_t的结构
}
@end

@implementation MYOSSpinLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    spinlock = OS_SPINLOCK_INIT;
    /**
     *  初始化
     *
     */
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
