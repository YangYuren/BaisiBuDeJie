//
//  XMGFastLogin.m
//  BaiSi
//
//  Created by Yang on 2017/4/24.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGFastLogin.h"

@implementation XMGFastLogin

+(instancetype)fastLogin{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XMGFastLogin class]) owner:nil options:nil] lastObject];
}

@end
