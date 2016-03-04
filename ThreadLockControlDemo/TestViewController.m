//
//  TestViewController.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)getImageNameWithMultiThread{
    NSArray *dateArray = @[@"NSLock",@"synchronized",@"DispatchSemaphore",@"NSCondition",@"NSConditionLock",@"NSRecursiveLock",@"POSIX",@"OSSpinLock",@"dispatch_barrier_async",@"dispatch_barrier_sync"];
    [dateArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id class = NSClassFromString([NSString stringWithFormat:@"%@Control",obj]);
        if ([class class]) {
            BaseControl *control = [[class alloc] init];
            control.title = obj;
            [control getImageNameWithMultiThread];
        }
    }];
    
}
@end
