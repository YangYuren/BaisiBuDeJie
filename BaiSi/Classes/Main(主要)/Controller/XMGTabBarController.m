//
//  XMGTabBarController.m
//  BaiSi
//
//  Created by Yang on 2017/4/21.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGTabBarController.h"

#import "XMGMeTableViewController.h"
#import "XMGEssenceViewController.h"
#import "XMGNewViewController.h"
#import "XMGPublishViewController.h"
#import "XMGFriendTrendViewController.h"
#import "UIImage+Ex.h"
#import "UIImage+Antialias.h"
#import "XMGTabBar.h"



@interface XMGTabBarController ()

@end

@implementation XMGTabBarController

//系统的TabBar添加子空间实在wiilAppear中实现

- (void)viewDidLoad {
    [super viewDidLoad];
    //替换UITabBar为XMGTabBar
    [self setupTabBar];
    //设置子控制器
    [self setupAllChildViewcontroller];
    //设置所有子标题
    [self setupAllTitleButton];
    
    
}
//把系统的tabBar换成自己定义的tabBar
-(void)setupTabBar{
    //kvc来设置私有的成员变量
    XMGTabBar * tabBar = [[XMGTabBar alloc] init];
    
    [self setValue:tabBar forKey:@"tabBar"];
}

-(void)setupAllChildViewcontroller{
    //添加5子控制器呢
    XMGEssenceViewController * essence = [[XMGEssenceViewController alloc] init];
    XMGNavigationViewController * nav1 = [[XMGNavigationViewController alloc] initWithRootViewController:essence];
    [self addChildViewController:nav1];
    
    XMGNewViewController * new = [[XMGNewViewController alloc] init];
    XMGNavigationViewController * nav2 = [[XMGNavigationViewController alloc] initWithRootViewController:new];
    [self addChildViewController:nav2];
    
    
    XMGFriendTrendViewController * friendTrend = [[XMGFriendTrendViewController alloc] init];
    XMGNavigationViewController * nav3 = [[XMGNavigationViewController alloc] initWithRootViewController:friendTrend];
    [self addChildViewController:nav3];
    
    UIStoryboard * stroybord = [UIStoryboard storyboardWithName:NSStringFromClass([XMGMeTableViewController class]) bundle:nil];
    XMGMeTableViewController * me = [stroybord instantiateInitialViewController];
    XMGNavigationViewController * nav4 = [[XMGNavigationViewController alloc] initWithRootViewController:me];
    [self addChildViewController:nav4];
    
    }

-(void)setupAllTitleButton{
    XMGNavigationViewController * nav1 = self.childViewControllers[0];
    nav1.tabBarItem.title = @"精华";
    nav1.tabBarItem.image = [UIImage originalImage:@"tabBar_essence_icon"];
    nav1.tabBarItem.selectedImage = [UIImage originalImage:@"tabBar_essence_click_icon"];
    
    XMGNavigationViewController * nav2 = self.childViewControllers[1];
    nav2.tabBarItem.title = @"新帖";
    nav2.tabBarItem.image = [UIImage originalImage:@"tabBar_new_icon"];
    nav2.tabBarItem.selectedImage = [UIImage originalImage:@"tabBar_new_click_icon"];
    
    XMGNavigationViewController * nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage originalImage:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage originalImage:@"tabBar_friendTrends_click_icon"];
    
    XMGNavigationViewController * nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage originalImage:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage =[UIImage originalImage:@"tabBar_me_click_icon"];
    
}

+(void)load{
    //拿到全局的TabBarItem
    UITabBarItem * item = [UITabBarItem appearance];
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    //设置字体大小  只有在正常清下才有用
    UITabBarItem * item1 = [UITabBarItem appearance];
    NSMutableDictionary * attrs1 = [NSMutableDictionary dictionary];
    attrs1[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item1 setTitleTextAttributes:attrs1 forState:UIControlStateNormal];
}

@end
