//
//  UIImageView+Download.m
//  BaiSi
//
//  Created by Yang on 2017/5/5.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "UIImageView+Download.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFNetworking.h>
@implementation UIImageView (Download)

-(void)xmg_setOriginImageWithURL:(NSString *)image1 andThumbnailImageWithURL:(NSString *)image0 placeholderImage:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock{
    // 根据网络状态来加载图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    //开启监控网络状态
    [mgr startMonitoring];
    // 获得原图（SDWebImage的图片缓存是用图片的url字符串作为key）
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:image1];
    // 原图已经被下载过
    if (originImage!=nil) {
        self.image = originImage;
        completedBlock(originImage,nil,0,[NSURL URLWithString:image1]);
        // 原图并未下载过
    } else {
        if(mgr.isReachableViaWiFi){
            //wifi直接下载
            [self sd_setImageWithURL:[NSURL URLWithString:image1] placeholderImage:placeholder completed:completedBlock];
        }else if(mgr.isReachableViaWWAN){
            //warning downloadOriginImageWhen3GOr4G配置项的值需要从沙盒里面获取
            // 3G\4G网络下时候要下载原图
            BOOL downloadOriginImageWhen3GOr4G = YES;
            if(downloadOriginImageWhen3GOr4G){
                [self sd_setImageWithURL:[NSURL URLWithString:image1] placeholderImage:placeholder completed:completedBlock];
            }else{
                [self sd_setImageWithURL:[NSURL URLWithString:image0] placeholderImage:placeholder completed:completedBlock];
            }
        }else{ // 没有可用网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:image0];
            
            if(thumbnailImage){ // 缩略图已经被下载过
                self.image = thumbnailImage;
                 completedBlock(originImage,nil,0,[NSURL URLWithString:image0]);
            }else{ // 没有下载过任何图片
                // 占位图片;
                self.image = placeholder;
            }
        }
    }
}

-(void)xmg_setupHeaderImage:(NSString *)profile_image{
    UIImage * placeHolder = [UIImage imageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:profile_image] placeholderImage:[placeHolder circleImage] options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.image = [image circleImage];
    }];

}


@end
