//
//  XMGButton.m
//  BaiSi
//
//  Created by Yang on 2017/4/26.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGButton.h"

@implementation XMGButton

//重写该方法,用户无法进入高亮该状态
-(void)setHighlighted:(BOOL)highlighted{
   
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}


@end
