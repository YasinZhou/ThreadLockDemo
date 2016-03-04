//
//  MYNSLockViewController.m
//  ThreadLock
//
//  Created by Yasin on 16/2/23.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "MYNSLockViewController.h"

@interface MYNSLockViewController ()
{
    NSLock *lock;
}
@end

@implementation MYNSLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lock = [[NSLock alloc]init];
}
- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    [lock lock];
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
    }
    [lock unlock];
}

@end
