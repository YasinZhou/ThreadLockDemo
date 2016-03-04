//
//  synchronizedControl.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "synchronizedControl.h"

@implementation synchronizedControl

- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    @synchronized(self) {
        if (imageNames.count>0) {
            imageName = [imageNames firstObject];
            [imageNames removeObjectAtIndex:0];
        }
    }
}

@end