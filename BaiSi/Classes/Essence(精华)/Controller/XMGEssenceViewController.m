//
//  XMGEssenceViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/21.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGButton.h"
@interface XMGEssenceViewController ()
@property(nonatomic,weak)UIScrollView * scroll;
@property(nonatomic,weak)UIView * titleView;
@property(nonatomic,weak)XMGButton * preButton;
@end

@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setupScrollView];
    [self setupTitleView];
}
//scroll的设置
-(void)setupScrollView{
    UIScrollView * scroll = [[UIScrollView alloc] init];
    scroll.backgroundColor = [UIColor blueColor];
    scroll.frame = self.view.frame;
    [self.view addSubview:scroll];

}
//标题栏
-(void)setupTitleView{
    UIView * titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    titleView.frame = CGRectMake(0, 64,XMGScreenW , 35);
    [self.view addSubview:titleView];
    self.titleView =  titleView;
    //加载标题按钮
    [self setupTitleButtons];
    //加载标题下划线
    [self setupTitleUnderLine];
}
-(void)setupTitleButtons{
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnH = self.titleView.xmg_height;
    CGFloat btnW = self.titleView.xmg_width/5;
    NSArray * arr = @[@"全部",@"视频",@"声音",@"图片",@"文字"];
    for(NSInteger i=0;i<5;i++){
        XMGButton * titleButton = [[XMGButton alloc] init];
        btnX = btnW * i;
        titleButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [titleButton setTitle:arr[i] forState:UIControlStateNormal];
        [self.titleView addSubview:titleButton];
        [titleButton addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    
}
//点击按钮事件
-(void)titleBtnClick:(XMGButton *)btn{
    //上一个按钮恢复颜色
    self.preButton.selected = NO;
    btn.selected = YES;
    //重新赋值上一个按钮
    self.preButton = btn;
}
//设置按钮下划线
-(void)setupTitleUnderLine{
    
}

-(void)setupNavBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage originalImage:@"nav_item_game_icon"] highImage:[UIImage originalImage:@"nav_item_game_click_icon"] Target:self action:@selector(game)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage originalImage:@"navigationButtonRandom"] highImage:[UIImage originalImage:@"navigationButtonRandomClick"] Target:self action:@selector(game)];
}

-(void)game{
    NSLog(@"000");
}


@end
