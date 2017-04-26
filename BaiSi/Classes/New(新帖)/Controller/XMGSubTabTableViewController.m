//
//  XMGSubTabTableViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/23.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGSubTabTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XMGSubTagItem.h"
#import <MJExtension/MJExtension.h>
#import "XMGSubTagCell.h"
#import <SVProgressHUD/SVProgressHUD.h>



@interface XMGSubTabTableViewController ()
@property(nonatomic,strong)NSArray * subtags;
@property(nonatomic,weak)AFURLSessionManager * mgr;

@end

@implementation XMGSubTabTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    // 注册cell  注册后就不需要绑定了
    
    //[self.tableView registerNib:[UINib nibWithNibName:@"XMGSubTagCell" bundle:nil] forCellReuseIdentifier:@"ID"];
    self.title = @"推荐标签";
   //处理cell分割线  用系统属性去解决 清空cell约束边缘
   //self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor grayColor];
    
    //指示器
    [SVProgressHUD showWithStatus:@"正在加载中....."];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //销毁指示器
    [SVProgressHUD dismiss];
    //取消网络请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}
//请求数据
-(void)loadData{
    AFHTTPSessionManager * mgr = [AFHTTPSessionManager manager];
    self.mgr = mgr;
    NSMutableDictionary * attr = [NSMutableDictionary dictionary];
    attr[@"a"]=@"tag_recommend";
    attr[@"action"]=@"sub";
    attr[@"c"]=@"topic";
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:attr progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        _subtags = [XMGSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subtags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(cell == nil){
        //从xib中加载  要绑定标识符号
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XMGSubTagCell class]) owner:nil options:nil] lastObject];
    }
    XMGSubTagItem * item = self.subtags[indexPath.row];
    cell.item = item;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


@end
