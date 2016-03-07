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
        //没过5秒进行一项测试，防止CPU占用冲突
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*idx * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            id class = NSClassFromString([NSString stringWithFormat:@"%@Control",obj]);
            if ([class class]) {
                BaseControl *control = [[class alloc] init];
                control.title = obj;
                [control getImageNameWithMultiThread];
            }
            if (idx == dateArray.count-1) {
                printf("\n\n\n");
            }
        });
        
    }];
    
}
@end
