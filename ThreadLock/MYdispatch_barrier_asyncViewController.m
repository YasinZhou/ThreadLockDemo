//
//  MYdispatch_barrier_asyncViewController.m
//  ThreadLock
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "MYdispatch_barrier_asyncViewController.h"

@interface MYdispatch_barrier_asyncViewController ()
{
    __block double then, now;
}
@end

@implementation MYdispatch_barrier_asyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
    }else{
        now = CFAbsoluteTimeGetCurrent();
        printf("thread_lock: %f sec\nimageNames count: %ld\n", now-then,imageNames.count);
    }
}

- (void)getImageNameWithMultiThread{
    NSMutableArray *imageNames = [NSMutableArray new];
    int count = 1024*11;
    for (int i=0; i<count; i++) {
        [imageNames addObject:[NSString stringWithFormat:@"%d",i]];
    }
    then = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<count+1; i++) {
        //100来测试锁有没有正确的执行
        dispatch_barrier_async(self.synchronizationQueue, ^{
            [self getIamgeName:imageNames];
        });
    }
}

@end
