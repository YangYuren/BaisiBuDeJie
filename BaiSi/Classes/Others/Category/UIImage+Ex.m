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
-(instancetype)circleImage{
    //开启上下文  比例因素：当前点与像素比例
    UIGraphicsBeginImageContextWithOptions(self.size,NO,0);
    //描述裁剪区域
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //设置剪裁区域
    [path addClip];
    //画图片
    [self drawAtPoint:CGPointZero];
    //取出图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return image;
}
@end
