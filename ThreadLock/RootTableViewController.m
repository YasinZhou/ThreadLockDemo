//
//  RootTableViewController.m
//  ThreadLock
//
//  Created by Yasin on 16/2/23.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "RootTableViewController.h"

@interface RootTableViewController ()
{
    NSArray *dateArray;
}
@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dateArray = @[@"atomic",@"NSLock",@"synchronized",@"DispatchSemaphore"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"线程锁";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dateArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rootCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rootCell"];
    }
    cell.textLabel.text = dateArray[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id class = NSClassFromString([NSString stringWithFormat:@"MY%@ViewController",dateArray[indexPath.row]]);
    if ([class class]) {
        UIViewController *view = [[class alloc]init];
        [self.navigationController pushViewController:view animated:YES];
    }
}

@end
