//
//  BaseViewController.m
//  ThreadLock
//
//  Created by Yasin on 16/2/25.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) dispatch_queue_t synchronizationQueue;
@end

@implementation BaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    
    self.synchronizationQueue = dispatch_queue_create([@"com.yasin.synchronization" cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_CONCURRENT);
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"取出图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(getImageNameWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)getIamgeName:(int)index{
    NSString *imageName;
    if (imageNames.count>0) {
        imageName = [imageNames lastObject];
        [imageNames removeObject:imageName];
    }
}

#pragma mark - 多线程取出图片后删除
- (void)getImageNameWithMultiThread{
    imageNames = [NSMutableArray new];
    int count = 1024*10;
    for (int i=0; i<count; i++) {
        [imageNames addObject:[NSString stringWithFormat:@"%d",i]];
    }
    dispatch_group_t dispatchGroup = dispatch_group_create();
    __block double then, now;
    then = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<count; i++) {
        dispatch_group_async(dispatchGroup, self.synchronizationQueue, ^(){
            [self getIamgeName:i];
        });
    }
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        now = CFAbsoluteTimeGetCurrent();
        printf("pthread_mutex: %f sec\n", now-then);
    });
    
}

@end
