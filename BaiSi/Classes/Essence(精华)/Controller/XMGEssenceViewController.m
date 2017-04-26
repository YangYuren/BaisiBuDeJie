//
//  XMGEssenceViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/21.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGEssenceViewController.h"

@interface XMGEssenceViewController ()

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
    scroll.backgroundColor = [UIColor greenColor];
    scroll.frame = self.view.frame;
    [self.view addSubview:scroll];

}
//标题栏
-(void)setupTitleView{
    UIView * titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    titleView.frame = CGRectMake(0, 64,XMGScreenW , 35);
    [self.view addSubview:titleView];
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
