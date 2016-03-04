//
//  BaseControl.h
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseControl : NSObject
@property(nonatomic,strong)NSString *title;
@property (nonatomic, readonly) dispatch_queue_t synchronizationQueue;
#pragma mark - 多线程取出图片后删除
- (void)getImageNameWithMultiThread;
- (void)getIamgeName:(NSMutableArray *)imageNames;
@end
