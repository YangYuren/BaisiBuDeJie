//
//  UIImage+Ex.m
//  A01-CZ彩票
//
//  Created by apple on 15/5/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIImage+Ex.h"

@implementation UIImage (Ex)
+ (instancetype)originalImage:(NSString *)imgName{
    UIImage *img = [UIImage imageNamed:imgName];
    return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+(instancetype)slipImage:(NSString *)imgName{
    UIImage * backImg = [UIImage imageNamed:imgName];
    backImg = [backImg stretchableImageWithLeftCapWidth:backImg.size.width*0.5 topCapHeight:backImg.size.height*0.5];
    return backImg;
}
@end
