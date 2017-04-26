//
//  XMGNavigationViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/22.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGNavigationViewController.h"

@interface XMGNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation XMGNavigationViewController

+(void)load{
    UINavigationBar * navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    //设置导航条的 UINavigationBar
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    //设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //只有风根控制器设置
    if(self.childViewControllers.count>0){
    //设置导航条左边按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] Target:self action:@selector(back) title:@"返回"];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
-(void)back{
    [self popViewControllerAnimated:YES];
}

/*
 <UIScreenEdgePanGestureRecognizer: 0x7fb5e8d07010; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fb5e8f0c860>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fb5e8d06ed0>)>>
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //防止假死状态  控制手势  什么时候出发
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    //self.interactivePopGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    //禁止之前的手势
    self.interactivePopGestureRecognizer.enabled = NO;
}
//控制手势触发
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press{
    if(self.childViewControllers.count>1){
        return YES;
    }else{
        return NO;
    }
}

@end
