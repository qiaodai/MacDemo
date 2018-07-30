//
//  DQRootTableVC.m
//  DQNavigationBar
//
//  Created by DaiQiao on 2018/7/28.
//  Copyright © 2018年 DaiQiao. All rights reserved.
//

#import "DQRootTableVC.h"

@interface DQRootTableVC ()

@end

@implementation DQRootTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    [self.tableView reloadData];
    /*******************/
    [self followScrollView:self.tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@" row - %ld",(long)indexPath.row];
    return cell;
}


@end
