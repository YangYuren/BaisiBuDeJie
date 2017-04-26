//
//  UIBarButtonItem+item.m
//  BaiSi
//
//  Created by Yang on 2017/4/22.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "UIBarButtonItem+item.h"

@implementation UIBarButtonItem (item)
+(UIBarButtonItem *)itemWithImage:(UIImage *)image1 highImage:(UIImage *)image2 Target:(id)target action:(SEL)action{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image1 forState:UIControlStateNormal];
    [btn setImage:image2 forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView * contentView = [[UIView alloc] initWithFrame:btn.bounds];
    [contentView addSubview:btn];
    UIBarButtonItem * Item = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    return Item;
}
+(UIBarButtonItem *)itemWithImage:(UIImage *)image1 selImage:(UIImage *)image2 Target:(id)target action:(SEL)action{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image1 forState:UIControlStateNormal];
    [btn setImage:image2 forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView * contentView = [[UIView alloc] initWithFrame:btn.bounds];
    [contentView addSubview:btn];
    UIBarButtonItem * Item = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    return Item;
}
//快速设置返回按钮
+(UIBarButtonItem *)backWithImage:(UIImage *)image1 highImage:(UIImage *)image2 Target:(id)target action:(SEL)action title:(NSString *)title{
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setImage:image1 forState:UIControlStateNormal];
    [backButton setImage:image2 forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item =  [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return item;
}
@end
