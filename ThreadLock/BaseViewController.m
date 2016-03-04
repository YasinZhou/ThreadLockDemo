//
//  BaseViewController.m
//  ThreadLock
//
//  Created by Yasin on 16/2/25.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()


@end

@implementation BaseViewController
-(void)dealloc{
    NSLog(@"%@释放了",NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *classStr = NSStringFromClass([self class]);
    NSString *title = [[[classStr componentsSeparatedByString:@"ViewController"] objectAtIndex:0] substringFromIndex:2];
    self.title = title;
    
    self.synchronizationQueue = dispatch_queue_create([@"com.yasin.synchronization" cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_CONCURRENT);
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 400, 220, 25);
    [button setTitle:@"取出图片" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getImageNameWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)getIamgeName:(NSMutableArray *)imageNames{//假如每个进来的都是一个线程
    //1.imageNames是线程外的变量，这个时候就需要考虑线程安全
    /*2.NSMutableArray *array = [[NSMutableArray alloc]initWithArray:imageNames];
    这里如果新生成一个array，下面也把imageNames换成array就不需要考虑线程安全，但是这样array.count判断永远大于0，也就是永远等于imageNames.count-1
     */
    NSString *imageName;
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
    }
}

#pragma mark - 多线程取出图片后删除
- (void)getImageNameWithMultiThread{
    NSMutableArray *imageNames = [NSMutableArray new];
    int count = 1024*10;
    for (int i=0; i<count; i++) {
        [imageNames addObject:[NSString stringWithFormat:@"%d",i]];
    }
    dispatch_group_t dispatchGroup = dispatch_group_create();
    __block double then, now;
    then = CFAbsoluteTimeGetCurrent();
    for (int i=0; i<count+100; i++) {
        //100来测试锁有没有正确的执行
        dispatch_group_async(dispatchGroup, self.synchronizationQueue, ^(){
            [self getIamgeName:imageNames];
        });
    }
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        now = CFAbsoluteTimeGetCurrent();
        printf("thread_lock: %f sec\nimageNames count: %ld\n", now-then,imageNames.count);
    });
    
}

@end
