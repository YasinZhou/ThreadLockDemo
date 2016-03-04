//
//  NSLockControl.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "NSLockControl.h"

@interface NSLockControl ()
{
    NSLock *lock;
}
@end

@implementation NSLockControl
-(instancetype)init{
    self = [super init];
    if (self) {
        lock = [[NSLock alloc]init];
    }
    return self;
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