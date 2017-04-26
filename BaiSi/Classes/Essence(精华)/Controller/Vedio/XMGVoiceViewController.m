//
//  XMGVoiceViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/26.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGVoiceViewController.h"

@interface XMGVoiceViewController ()

@end

@implementation XMGVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XMGRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(XMGTitleViewH+XMGNavigatinH, 0,XMGTarBarH, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%zd",self.class,indexPath.row];
    return cell;
}
@end
