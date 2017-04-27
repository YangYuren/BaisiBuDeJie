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
@property(nonatomic,weak)UIView * headerView;
@property(nonatomic,weak)UILabel * footerLabel;
@property(nonatomic,weak)UILabel * headerLabel;
@property(nonatomic,assign,getter=isFooterRefreashing)BOOL footerRefreashing;
@property(nonatomic,assign,getter=isHeaderRefreashing)BOOL headerRefreashing;
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
    //headerView
    UIView * headerView = [[UIView alloc] init];
    self.headerView = headerView;
    headerView.frame = CGRectMake(0, -50, self.tableView.xmg_width, 50);
    headerView.backgroundColor = [UIColor redColor];
    UILabel * headerLabel = [UILabel new];
    self.headerLabel = headerLabel;
    headerLabel.text = @"下拉可以加载更多";
    headerLabel.frame = headerView.bounds;
    headerLabel.textColor =[UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:headerLabel];
    [self.tableView addSubview:headerView];
    //让header自动进入刷新
    [self headerBeginRefreshing];
    
    //footerView
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
    //刷新数据 进入下拉刷新
    [self headerBeginRefreshing];
}
//监听标题按钮重复使用
-(void)titleButtonDidRepeatClick{
    [self tabBarButtonDidRepeatClick];
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
    //监听拖拽
    [self setupHeader];
    [self setupFooter];
}
//处理header
-(void)setupHeader{
    if(self.isHeaderRefreashing) return;
    CGFloat offsetY = -(self.tableView.contentInset.top + self.headerView.xmg_height);
    if(self.tableView.contentOffset.y<=offsetY){
        self.headerLabel.text = @"松开立即刷新";
    }else{
        self.headerLabel.text = @"下拉可以加载更多";
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    CGFloat offsetY = -(self.tableView.contentInset.top + self.headerView.xmg_height);
    if(self.tableView.contentOffset.y<=offsetY){
        //上拉开始刷新
        [self headerBeginRefreshing];
    }
}
//处理foot
-(void)setupFooter{
    //刚开始加载时候ContentSize为0
    if(self.tableView.contentSize.height==0)return;
    //防止多次发送请求
    if(self.isFooterRefreashing)return;
    CGFloat offsetY = self.tableView.contentSize.height+self.tableView.contentInset.bottom - self.tableView.frame.size.height;
    if(self.tableView.contentOffset.y>=offsetY && self.tableView.contentOffset.y>-(self.tableView.contentInset.top)){
        [self footerBeginRefreshing];
    }
}
#pragma mark -数据处理
//下拉
-(void)loadNewData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataCount = 20;
        [self.tableView reloadData];
        //结束刷新
        [self headerEndRefreshing];
    });
    
}
//上拉
-(void)loadMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataCount += 5;
        [self.tableView reloadData];
        //结束刷新
        [self footerEndRefreshing];
    });
    
}
#pragma mark - header
-(void)headerBeginRefreshing{
    if(self.isHeaderRefreashing) return;
    self.headerLabel.text = @"正在刷新..";
    self.headerView.backgroundColor = [UIColor grayColor];
    self.headerRefreashing = YES;
    //增加内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.headerView.xmg_height;
        self.tableView.contentInset = inset;
        //修改偏移量
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, -inset.top);
    }];
    //发送请求给服务器
    [self loadNewData];
}

-(void)headerEndRefreshing{
    self.headerRefreashing = NO;
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.headerView.xmg_height;
        self.tableView.contentInset = inset;
        self.headerView.backgroundColor = [UIColor redColor];
    }];
    
}

#pragma mark - footer
-(void)footerBeginRefreshing{
    //如果正在上拉...
    if(self.isFooterRefreashing) return;
    //进入刷新状态
    self.footerRefreashing = YES;
    self.footerLabel.text = @"正在加载更多数据....";
    //发送请求给服务器
    [self loadMoreData];
}

-(void)footerEndRefreshing{
    self.footerRefreashing = NO;
    self.footerLabel.text = @"上拉可以加载更多";
}

@end
