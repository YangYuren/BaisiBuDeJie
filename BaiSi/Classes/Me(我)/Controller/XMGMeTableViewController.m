//
//  XMGMeTableViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/21.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGMeTableViewController.h"
#import "XMGSettigTableViewController.h"
#import "XMGSquareCollectionViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "XMGSquare.h"
#import <SafariServices/SafariServices.h>
#import "XMGWebViewController.h"

static NSInteger const cols = 4;
static NSInteger const margin = 1;

#define itemWH (XMGScreenW-(cols-1)*margin)/cols

@interface XMGMeTableViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SFSafariViewControllerDelegate>
@property(nonatomic,strong)NSMutableArray * squareArr;
@property(nonatomic,weak)UICollectionView * collection;

@end

@implementation XMGMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupFootView];
    [self loadData];
    //设置cell间距 默认tableView分组样式  有额外的头部与尾部的间距
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    //额外的顶部间距为64 但是第一个cell的y值为35  所以  让额外的顶部间距减去25  相当于向上平移25
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}
#pragma mark - collection 代理方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XMGSquare * square  = self.squareArr[indexPath.row];
    if([square.url containsString:@"http"]){
        //跳转界面
        NSURL * url = [NSURL URLWithString:square.url];
        //SFSafariViewController * safari = [[SFSafariViewController alloc] initWithURL:url];
        //safari.delegate = self;
        //苹果推荐使用model的方式  导航条自动会隐藏
        //[self presentViewController:safari animated:YES completion:nil];
        
        //webKit来实现跳转
        XMGWebViewController * webVC = [[XMGWebViewController alloc] init];
        webVC.url = url;
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        return;
    }
}
#pragma mark -safari代理方法
//-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//加载网络 数据
-(void)loadData{
    AFHTTPSessionManager * mag = [AFHTTPSessionManager manager];
    mag.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[@"a"]=@"square";
    attrs[@"c"] = @"topic";
    [mag GET:@"http://api.budejie.com/api/api_open.php" parameters:attrs progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * dict = responseObject[@"square_list"];
       
        _squareArr = [XMGSquare mj_objectArrayWithKeyValuesArray:dict];
        [self resolveData];
        //设置collection属性
        NSInteger Rows = (self.squareArr.count-1)/cols + 1;
        //加10 因为为了不让collection紧贴TabBar
        self.collection.xmg_height = Rows * itemWH + 10;
        //还要设置tableView的滚动范围
        self.tableView.tableFooterView = self.collection;
        //禁止collection滚动
        self.collection.scrollEnabled = NO;
        //刷新表格
         [self.collection reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
//处理请求完成的数据
-(void)resolveData{
    //判断缺几个数据
    NSInteger count = self.squareArr.count;
    NSInteger exetr = (count % cols);
    if(exetr!=0){
        exetr = cols -exetr;
        for(int i=0 ;i<exetr;i++){
            XMGSquare * item = [[XMGSquare alloc] init];
            [self.squareArr addObject:item];
        }
    }
}
//设置footView
-(void)setupFootView{
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc] init];
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    _collection = collectionView;
    self.tableView.tableFooterView =collectionView;
    
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    //最小行间距  与 最小列间距
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"XMGSquareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellID"];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
}
#pragma mark - collection代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.squareArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XMGSquareCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    XMGSquare * square = self.squareArr[indexPath.item];
    cell.square = square;
    return cell;
}
//设置按钮夜间模式
-(void)setupNavBar{
    UIBarButtonItem * settingitem = [UIBarButtonItem itemWithImage:[UIImage originalImage:@"mine-setting-icon"] highImage:[UIImage originalImage:@"mine-setting-icon-click"] Target:self action:@selector(set)];
    UIBarButtonItem * nightItem = [UIBarButtonItem itemWithImage:[UIImage originalImage:@"mine-moon-icon"] selImage:[UIImage originalImage:@"mine-moon-icon-click"] Target:self action:@selector(night:)];
    self.navigationItem.rightBarButtonItems = @[settingitem,nightItem];
    self.navigationItem.title = @"我的";
  
}
//设置按钮跳转
-(void)set{
    XMGSettigTableViewController * set = [[XMGSettigTableViewController alloc] init];
    [self.navigationController pushViewController:set animated:YES];
}

-(void)night:(UIButton *)btn{
    btn.selected = !btn.selected;
}


@end
