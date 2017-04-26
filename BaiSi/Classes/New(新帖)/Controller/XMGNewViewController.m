//
//  XMGNewViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/21.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGNewViewController.h"
#import "XMGSubTabTableViewController.h"
@interface XMGNewViewController ()

@end

@implementation XMGNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
}


-(void)setupNavBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage originalImage:@"MainTagSubIcon"] highImage:[UIImage originalImage:@"MainTagSubIconClick"] Target:self action:@selector(tagClick)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}
//进入到推荐标签界面
-(void)tagClick{
    XMGSubTabTableViewController * subtag = [[XMGSubTabTableViewController alloc] init];
    [self.navigationController pushViewController:subtag animated:YES];
}

@end
