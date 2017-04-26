//
//  XMGEssenceViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/21.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGButton.h"
#import "XMGWordViewController.h"
#import "XMGAllViewController.h"
#import "XMGPictureViewController.h"
#import "XMGVedioViewController.h"
#import "XMGVoiceViewController.h"

@interface XMGEssenceViewController ()
@property(nonatomic,weak)UIScrollView * scroll;
@property(nonatomic,weak)UIView * titleView;
@property(nonatomic,weak)XMGButton * preButton;
@property(nonatomic,weak)UIView *lineView;

@end

@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化自控制器
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupChildViewController];
    
    [self setupNavBar];
    //设置scrollView
    [self setupScrollView];
    //设置标题
    [self setupTitleView];
}
//初始化自控制器
-(void)setupChildViewController{
    [self addChildViewController:[[XMGAllViewController alloc] init]];
    [self addChildViewController:[[XMGVedioViewController alloc] init]];
    [self addChildViewController:[[XMGVoiceViewController alloc] init]];
    [self addChildViewController:[[XMGPictureViewController alloc] init]];
    [self addChildViewController:[[XMGWordViewController alloc] init]];
}
//scroll的设置
-(void)setupScrollView{
    
    
    UIScrollView * scroll = [[UIScrollView alloc] init];
    scroll.backgroundColor = [UIColor blueColor];
    scroll.frame = self.view.frame;
    [self.view addSubview:scroll];
    CGFloat scrollViewW = scroll.xmg_width;
    CGFloat scrollViewH = scroll.xmg_height;
    for(NSInteger i=0;i<5;i++){
        UIViewController * vc = self.childViewControllers[i];
        //由于历史遗留问题   IOS7之后状态栏归控制器虽有  所有在添加空间的时候y值默认加20 所以下面在设置y值的时候  一定要指定为0  在指定为scroll的高度
        vc.view.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        [scroll addSubview:vc.view];
    }
    
    self.scroll = scroll;
    scroll.contentSize = CGSizeMake(5*scrollViewW, 0);
    
    scroll.bounces = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.pagingEnabled = YES;
}
//标题栏
-(void)setupTitleView{
    UIView * titleView = [[UIView alloc] init];
    
    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    titleView.frame = CGRectMake(0, XMGNavigatinH,XMGScreenW , XMGTitleViewH);
    [self.view addSubview:titleView];
    self.titleView =  titleView;
    //加载标题按钮
    [self setupTitleButtons];
    //加载标题下划线
    [self setupTitleUnderLine];
}
//设置标题按钮
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
        //设置按钮标记号
        titleButton.tag = i;
        
        //调整字体大小
        [titleButton addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
//点击按钮事件
-(void)titleBtnClick:(XMGButton *)btn{
    //上一个按钮恢复颜色
    self.preButton.selected = NO;
    btn.selected = YES;
    //重新赋值上一个按钮
    self.preButton = btn;
    [UIView animateWithDuration:0.25 animations:^{
        
        //获取文字宽度 先获取文字  在计算文字宽度
//        NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
//        attrs[NSFontAttributeName] = btn.titleLabel.font;
//        self.lineView.xmg_width = [btn.currentTitle sizeWithAttributes:attrs].width;
        
//        //第二种计算方式  直接等于Label的宽度
        self.lineView.xmg_width = btn.titleLabel.xmg_width+10;
        
        //设置中心点
        self.lineView.xmg_centerX = btn.xmg_centerX;
        
        //self.scroll.contentOffset = CGPointMake(btn.tag * self.scroll.xmg_width, 0);
    }];
}
//设置按钮下划线
-(void)setupTitleUnderLine{
    XMGButton * titleButton = self.titleView.subviews.firstObject;
    UIView * lineView = [[UIView alloc] init];
    
    
    lineView.xmg_height = 2;
    lineView.xmg_y = self.titleView.xmg_height-lineView.xmg_height;
    
    lineView.backgroundColor = [titleButton titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:lineView];
    self.lineView = lineView;
    
    [titleButton.titleLabel sizeToFit];
    //设置第一个按钮为默认按钮
    self.preButton.selected = NO;
    titleButton.selected = YES;
    //重新赋值上一个按钮
    self.preButton = titleButton;
    self.lineView.xmg_width = titleButton.titleLabel.xmg_width+10;
    self.lineView.xmg_centerX = titleButton.xmg_centerX;

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
