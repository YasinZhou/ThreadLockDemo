//
//  MYDispatchSemaphoreViewController.m
//  ThreadLock
//
//  Created by Yasin on 16/2/25.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "MYDispatchSemaphoreViewController.h"

@interface MYDispatchSemaphoreViewController ()
{
    dispatch_semaphore_t semaphore;
}
@end

@implementation MYDispatchSemaphoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    semaphore = dispatch_semaphore_create(1);
    /**
     *  创建一个信号量为1的信号
     *
     */
}

- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    /**
     *  semaphore：等待信号
     DISPATCH_TIME_FOREVER：等待时间
     wait之后信号量-1，为0
     */
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
    }
    /**
     *  发送一个信号通知，这时候信号量+1，为1
     */
    dispatch_semaphore_signal(semaphore);
}

@end
