//
//  XMGSettigTableViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/22.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGSettigTableViewController.h"
#import <SDWebImage/SDImageCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "XMGFileTool.h"

#define path [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface XMGSettigTableViewController ()
@property(nonatomic,assign)NSInteger totalSize;
@end

@implementation XMGSettigTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:0 target:self action:@selector(jump)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
    [SVProgressHUD showWithStatus:@"正在计算缓存...."];
    //计算文件大小
    [XMGFileTool getFileSize:path completion:^(NSInteger totalSize){
        self.totalSize = totalSize;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    
}
-(void)jump{
    UIViewController * vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    //获取Cache文件夹的尺寸
    cell.textLabel.text = [self sizeStr];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除内容
    [XMGFileTool removeDirectoryPath:path];
    //清空 self.totalSize
    self.totalSize = 0;
    
    //刷新表格
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
//获得缓存尺寸字符串
-(NSString *)sizeStr{
    NSInteger totalSize = self.totalSize;
    NSString * sizeStr = @"清除缓存";
    if(totalSize>1000*1000){
        //MB
        CGFloat sizeF = totalSize/1000.0/1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    }else if(totalSize>1000){
        //KB
        CGFloat sizeF = totalSize/1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    }else if(totalSize>0){
        //B
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    return sizeStr;
}
@end
