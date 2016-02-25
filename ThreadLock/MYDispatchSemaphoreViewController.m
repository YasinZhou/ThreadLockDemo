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
}

- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    /**
     *  semaphore：等待信号
     DISPATCH_TIME_FOREVER：等待时间
     */
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    @synchronized(self) {
        if (imageNames.count>0) {
            imageName = [imageNames lastObject];
            [imageNames removeObject:imageName];
        }
    }
    dispatch_semaphore_signal(semaphore);
}

@end
