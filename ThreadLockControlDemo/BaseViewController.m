//
//  BaseViewController.m
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
-(instancetype)initWithControl:(BaseControl *)control
{
    self = [super init];
    if (self) {
        _control = control;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 400, 220, 25);
    [button setTitle:@"getImageName" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getImageNameWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.control.title = self.title;
}

- (void)getImageNameWithMultiThread{
    [self.control getImageNameWithMultiThread];
}

@end
