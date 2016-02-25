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
- (void)getIamgeName:(int)index{
    NSString *imageName;
    [lock lock];
    if (imageNames.count>0) {
        imageName = [imageNames lastObject];
        [imageNames removeObject:imageName];
    }
    [lock unlock];
}

@end
