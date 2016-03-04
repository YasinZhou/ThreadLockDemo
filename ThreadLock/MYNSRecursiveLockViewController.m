//
//  MYNSRecursiveLockViewController.m
//  ThreadLock
//
//  Created by Yasin on 16/3/2.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "MYNSRecursiveLockViewController.h"

@interface MYNSRecursiveLockViewController ()
{
    NSRecursiveLock *lock;
}
@end

@implementation MYNSRecursiveLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lock = [[NSRecursiveLock alloc]init];
}
- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    [lock lock];
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
        [self getIamgeName:imageNames];
        
    }
    [lock unlock];
}
- (void)getImageNameWithMultiThread{
    NSMutableArray *imageNames = [NSMutableArray new];
    int count = 1024*10;
    for (int i=0; i<count; i++) {
        [imageNames addObject:[NSString stringWithFormat:@"%d",i]];
    }
    dispatch_group_t dispatchGroup = dispatch_group_create();
    __block double then, now;
    then = CFAbsoluteTimeGetCurrent();
    dispatch_group_async(dispatchGroup, self.synchronizationQueue, ^(){
        [self getIamgeName:imageNames];
    });
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        now = CFAbsoluteTimeGetCurrent();
        printf("thread_lock: %f sec\nimageNames count: %ld\n", now-then,imageNames.count);
    });
}
@end
