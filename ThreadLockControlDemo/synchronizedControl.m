//
//  synchronizedControl.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "synchronizedControl.h"

@implementation synchronizedControl

- (void)getIamgeName{
    while (true) {
        NSString *imageName;
        @synchronized(self) {
            if (imageNameArray.count>0) {
                imageName = [imageNameArray firstObject];
                [imageNameArray removeObjectAtIndex:0];
            } else {
                now = CFAbsoluteTimeGetCurrent();
                printf("%30s_lock: %f sec-----imageNames count: %ld\n",[self.title UTF8String] , now-then,imageNameArray.count);
                return;
            }
        }
    }
    
}
@end