//
//  UIImage+Ex.h
//  A01-CZ彩票
//
//  Created by apple on 15/5/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ex)
+ (instancetype)originalImage:(NSString *)imgName;
+(instancetype)slipImage:(NSString *)imgName;
-(instancetype)circleImage;
@end
