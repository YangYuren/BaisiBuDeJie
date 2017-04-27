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
    //滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:XMGTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:XMGTitleButtonDidRepeatClickNotification object:nil];
}
//监听TabBar按钮重复使用
-(void)tabBarButtonDidRepeatClick{
    //判断当前控制器View是否在window中
    if(self.view.window == nil)return;
    //判断当前AllView中  只刷新显示的tableView
    if(self.tableView.scrollsToTop == NO)return;
    //刷新数据
    NSLog(@"tabBar----刷新吧");
}
//监听标题按钮重复使用
-(void)titleButtonDidRepeatClick{
    //判断当前控制器View是否在window中
    if(self.view.window == nil)return;
    //判断当前AllView中  只刷新显示的tableView
    if(self.tableView.scrollsToTop == NO)return;
    //刷新数据
    NSLog(@"title----刷新吧");
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%zd",self.class,indexPath.row];
    return cell;
}
@end
