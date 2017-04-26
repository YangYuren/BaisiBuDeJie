//
//  XMGLoginField.m
//  BaiSi
//
//  Created by Yang on 2017/4/24.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGLoginField.h"

@implementation XMGLoginField

//文本框光标变成变白色  文本框开始编辑的时候 占位文字变成白色
//从xib中加载  且只加载一次
-(void)awakeFromNib{
    //设置光标颜色为白色
    [super awakeFromNib];
    
    self.tintColor = [UIColor whiteColor];
    //占位文字变成白色 监听文本框编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
//    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder =[[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
    
    //第二种方法  快速设置
    //UILabel * label = [self valueForKey:@"placeholderLabel"];
    //label.textColor =[UIColor lightGrayColor];
    
    //第三种方法  为UITextFiled 添加一个分类
    
    self.placeholderFast = [UIColor lightGrayColor];
    
    
}
-(void)textBegin{
    //设置站为文字变成白色
//    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder =[[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];

    //第二种方法  快速设置
    UILabel * label = [self valueForKey:@"placeholderLabel"];
    label.textColor =[UIColor whiteColor];
}
-(void)textEnd{
    //设置站为文字变成白色
//    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor  lightGrayColor];
//    self.attributedPlaceholder =[[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
    
    //第二种方法  快速设置
    UILabel * label = [self valueForKey:@"placeholderLabel"];
    label.textColor =[UIColor lightGrayColor];
    
}
//占位文字可能是个label

@end
