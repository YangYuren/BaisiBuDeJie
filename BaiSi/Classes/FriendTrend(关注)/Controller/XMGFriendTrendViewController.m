//
//  XMGFriendTrendViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/21.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGFriendTrendViewController.h"
#import "XMGLoginRegisterViewController.h"
@interface XMGFriendTrendViewController ()

@end

@implementation XMGFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
}

//进入登录注册
- (IBAction)clickLogin:(id)sender {
    XMGLoginRegisterViewController * login = [[XMGLoginRegisterViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}

-(void)setupNavBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage originalImage:@"friendsRecommentIcon"] highImage:[UIImage originalImage:@"friendsRecommentIcon-click"] Target:nil action:nil];
    self.navigationItem.title = @"我的关注";
}


@end
