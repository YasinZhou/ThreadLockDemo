//
//  BaseViewController.h
//  ThreadLockControlDemo
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseControl.h"
@interface BaseViewController : UIViewController

@property(nonatomic,readonly)BaseControl *control;

-(instancetype)initWithControl:(BaseControl *)control;
@end
