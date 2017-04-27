//
//  XMGAllViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/26.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGAllViewController.h"

@interface XMGAllViewController ()
@property(nonatomic,weak)UIView * footerView;
@property(nonatomic,weak)UILabel * footerLabel;
@property(nonatomic,assign,getter=isFooterRefreashing)BOOL footerRefreashing;
@property(nonatomic,assign)NSInteger  dataCount;
@end

@implementation XMGAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = XMGRandomColor;
   
    
    self.tableView.contentInset = UIEdgeInsetsMake(XMGTitleViewH+XMGNavigatinH, 0, XMGTarBarH, 0);
    //滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:XMGTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:XMGTitleButtonDidRepeatClickNotification object:nil];
    self.dataCount = 7;
    //数据刷新
    [self setupRefreash];
}
//下拉刷新
-(void)setupRefreash{
    UIView * footerView = [[UIView alloc] init];
    self.footerView = footerView;
    footerView.frame = CGRectMake(0, 0, self.tableView.xmg_width, 35);
    footerView.backgroundColor = [UIColor redColor];
    UILabel * footerLabel = [UILabel new];
    self.footerLabel = footerLabel;
    footerLabel.text = @"上拉可以加载更多";
    footerLabel.frame = footerView.bounds;
    footerLabel.textColor =[UIColor whiteColor];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:footerLabel];
    self.tableView.tableFooterView = footerView;
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
#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.dataCount ==0 )self.footerView.hidden = YES;
    return self.dataCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%zd",self.class,indexPath.row];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //刚开始加载时候ContentSize为0
    if(self.tableView.contentSize.height==0)return;
    //防止多次发送请求
    if(self.isFooterRefreashing)return;
    CGFloat offsetY = self.tableView.contentSize.height+self.tableView.contentInset.bottom - self.tableView.frame.size.height-self.tableView.tableFooterView.xmg_height/2;
    if(self.tableView.contentOffset.y>offsetY){
        self.footerRefreashing = YES;
        self.footerLabel.text = @"正在加载更多数据....";
        //发送请求给服务器
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.dataCount += 5;
            self.footerRefreashing = NO;
            [self.tableView reloadData];
            self.footerLabel.text = @"上拉可以加载更多";
        });
    }
}

@end
