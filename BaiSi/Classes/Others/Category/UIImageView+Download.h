//
//  UIImageView+Download.h
//  BaiSi
//
//  Created by Yang on 2017/5/5.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UIImageView (Download)
//设置图片下载
-(void)xmg_setOriginImageWithURL:(NSString *)image1 andThumbnailImageWithURL:(NSString *)image0 placeholderImage:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock;
//封装下载圆形头像
-(void)xmg_setupHeaderImage:(NSString *)profile_image;

@end
