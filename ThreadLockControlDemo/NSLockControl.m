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
- (void)getIamgeName{
    while (true) {
        NSString *imageName;
        [lock lock];
        if (imageNameArray.count>0) {
            imageName = [imageNameArray firstObject];
            [imageNameArray removeObjectAtIndex:0];
        } else {
            now = CFAbsoluteTimeGetCurrent();
            printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
            [lock unlock];
            return;
        }
        [lock unlock];
    }
    
}
@end