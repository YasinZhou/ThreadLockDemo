//
//  MYNSConditionLockViewController.m
//  ThreadLock
//
//  Created by Yasin on 16/3/2.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "MYNSConditionLockViewController.h"

@interface MYNSConditionLockViewController ()
{
    NSConditionLock *lock;
}
@end

@implementation MYNSConditionLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lock = [[NSConditionLock alloc]init];
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

#pragma mark - 下面的是测试多线程之间的通信调用
//- (void)getIamgeName:(NSMutableArray *)imageNames{
//    NSString *imageName;
//    [lock lockWhenCondition:1];    //加锁
////    static int m = 0;
////    NSLog(@"removeObjectBegin count: %ld\n",imageNames.count);
//    if (imageNames.count>0) {
//        imageName = [imageNames lastObject];
//        [imageNames removeObjectAtIndex:0];
////        m++;
////        NSLog(@"执行了%d次删除操作",m);
//    }
////    NSLog(@"removeObject count: %ld\n",imageNames.count);
//    [lock unlockWithCondition:0];     //解锁
//}
//- (void)createImageName:(NSMutableArray *)imageNames{
//    [lock lockWhenCondition:0];
////    static int m = 0;
//    [imageNames addObject:@"0"];
////    m++;
////    NSLog(@"添加了%d次",m);
////    NSLog(@"createImageName count: %ld\n",imageNames.count);
//    [lock unlockWithCondition:1];
//}
//
//#pragma mark - 多线程取出图片后删除
//- (void)getImageNameWithMultiThread{
//    NSMutableArray *imageNames = [[NSMutableArray alloc]init];
//    dispatch_group_t dispatchGroup = dispatch_group_create();
//    __block double then, now;
//    then = CFAbsoluteTimeGetCurrent();
//    for (int i=0; i<1024*11; i++) {
//        dispatch_group_async(dispatchGroup, self.synchronizationQueue, ^(){
//            [self getIamgeName:imageNames];
//        });
//        dispatch_group_async(dispatchGroup, self.synchronizationQueue, ^(){
//            [self createImageName:imageNames];
//        });
//    }
//    dispatch_group_notify(dispatchGroup, self.synchronizationQueue, ^(){
//        now = CFAbsoluteTimeGetCurrent();
//        printf("thread_lock: %f sec\nimageNames count: %ld\n", now-then,imageNames.count);
//    });
//    
//}

@end
