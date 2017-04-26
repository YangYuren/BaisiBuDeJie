//
//  XMGFastButton.m
//  BaiSi
//
//  Created by Yang on 2017/4/24.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGFastButton.h"

@implementation XMGFastButton
-(void)layoutSubviews{
    //重新布局按钮子控件位置
    [super layoutSubviews];
    //设置图片位置
    self.imageView.xmg_y = 0;
    self.imageView.xmg_centerX = self.xmg_width * 0.5;
    //设置标题为止
    self.titleLabel.xmg_y = self.xmg_height - self.titleLabel.xmg_height;
    
    //计算文字宽度 设置label的宽度
    [self.titleLabel sizeToFit];
    
    //必须适配后才可以设置文字center
    self.titleLabel.xmg_centerX = self.xmg_width * 0.5;
   
    
}
@end
