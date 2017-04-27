//
//  XMGTabBar.m
//  BaiSi
//
//  Created by Yang on 2017/4/22.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGTabBar.h"

@interface XMGTabBar()
//中间加号按钮
@property(nonatomic,weak)UIButton * plusButton;
//上一次点击按钮
@property(nonatomic,weak)UIControl *preControl;
@end

@implementation XMGTabBar
-(UIButton *)plusButton{
    if(_plusButton == nil){
        UIButton * plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        [plusButton sizeToFit];
        _plusButton = plusButton;
        [self addSubview:plusButton];
    }
    return _plusButton;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //布局TabBarButton
    NSInteger count = self.items.count + 1;
    CGFloat btnW = self.frame.size.width/(count);
    //自定义求高
    CGFloat btnH = [self xmg_height];
    CGFloat btnX = 0;
    NSInteger i =0;
    for (UIControl *tabBarButton  in self.subviews) {
        //UITabBarButton 是系统私有属性  拿不到
        if([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            if(i==2){
                i+=1;
            }
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, 0, btnW, btnH);
            if(i==0 && self.preControl == nil){
                self.preControl = tabBarButton;
            }
            i++;
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }
    self.plusButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
}

-(void)tabBarButtonClick:(UIControl *)tabBar{
    if(self.preControl == tabBar){
        //发出通知告知TabBar被重发点击了
        [[NSNotificationCenter defaultCenter] postNotificationName:XMGTabBarButtonDidRepeatClickNotification object:nil];
    }
    self.preControl =tabBar;
}














@end
