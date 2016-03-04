//
//  MYPOSIXViewController.m
//  ThreadLock
//
//  Created by Yasin on 16/3/3.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "MYPOSIXViewController.h"
#import <pthread.h>
@interface MYPOSIXViewController ()
{
    pthread_mutex_t mutex;  //声明pthread_mutex_t的结构
}
@end

@implementation MYPOSIXViewController
- (void)dealloc{
    pthread_mutex_destroy(&mutex);  //释放该锁的数据结构
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pthread_mutex_init(&mutex, NULL);
    /**
     *  初始化
     *
     */
}

- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    /**
     *  加锁
     */
    pthread_mutex_lock(&mutex);
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
    }
    /**
     *  解锁
     */
    pthread_mutex_unlock(&mutex);

}


@end
