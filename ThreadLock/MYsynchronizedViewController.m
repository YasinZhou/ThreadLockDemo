//
//  MYsynchronizedViewController.m
//  ThreadLock
//
//  Created by Yasin on 16/2/25.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "MYsynchronizedViewController.h"

@interface MYsynchronizedViewController ()
@end

@implementation MYsynchronizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    @synchronized(self) {
        if (imageNames.count>0) {
            imageName = [imageNames lastObject];
            [imageNames removeObject:imageName];
        }
    }
}


@end
