//
//  UIBarButtonItem+item.h
//  BaiSi
//
//  Created by Yang on 2017/4/22.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)

//快速创建对象方法
+(UIBarButtonItem *)itemWithImage:(UIImage *)image1 highImage:(UIImage *)image2 Target:(id)target action:(SEL)action;

+(UIBarButtonItem *)itemWithImage:(UIImage *)image1 selImage:(UIImage *)image2 Target:(id)target action:(SEL)action;

+(UIBarButtonItem *)backWithImage:(UIImage *)image1 highImage:(UIImage *)image2 Target:(id)target action:(SEL)action title:(NSString *)title;
@end
