//
//  XMGAdViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/23.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGAdViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XMGADitem.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "XMGTabBarController.h"
#define Code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"
@interface XMGAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContentView;
@property(nonatomic,weak) UIImageView * adView;
@property(nonatomic,strong)XMGADitem * item;
@property(nonatomic,weak)NSTimer * timer;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@end

@implementation XMGAdViewController


-(UIImageView *)adView{
    if(_adView == nil){
        UIImageView  * adView= [UIImageView new];
        
        [self.adContentView addSubview: adView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [adView addGestureRecognizer:tap];
        adView.userInteractionEnabled = YES;
        _adView = adView;
    }
    return _adView;
}
- (IBAction)jumpClick:(id)sender {
    //销毁广告界面  进入主框架
    XMGTabBarController * tabVC = [[XMGTabBarController alloc] init];
    [[UIApplication sharedApplication] keyWindow].rootViewController = tabVC;
    
    //去除定时器
    [self.timer invalidate];

}
//点击广告界面就调用
-(void)tap{
    //跳转界面
    NSURL * url = [NSURL URLWithString:_item.ori_curl];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置启动图片
    [self setupLaunchImage];
    //请求数据
    [self addDate];
    //创建定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}
-(void)timeChange{
    static int i = 3;
    if(i==0){
        //销毁广告界面  进入主框架
        XMGTabBarController * tabVC = [[XMGTabBarController alloc] init];
        [[UIApplication sharedApplication] keyWindow].rootViewController = tabVC;
        
        //去除定时器
        [self.timer invalidate];
    }
    i--;
    [self.jumpBtn setTitle:[NSString stringWithFormat:@"跳转(%d)",i] forState:UIControlStateNormal];
    
}
//加载广告数据
-(void)addDate{
    AFHTTPSessionManager * mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"]=Code2;
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary * dict = [responseObject[@"ad"] lastObject];
        _item = [XMGADitem mj_objectWithKeyValues:dict];

        //创建UIImageView展示图片
        CGFloat h = XMGScreenW/_item.w * _item.h;
        self.adView.frame =CGRectMake(0, 0, XMGScreenW, h);
        //加载网络图片
        [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)setupLaunchImage{
    //判断当前设备
    UIImage * image;
    if(iphone67Plus){
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if(iphone67){
        image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
    }else if(iphone55s){
        image = [UIImage imageNamed:@"LaunchImage-568h@2x"];
    }else{
        image = [UIImage imageNamed:@"LaunchImage-700@2x"];
    }
    self.launchImageView.image =image;
}

@end
