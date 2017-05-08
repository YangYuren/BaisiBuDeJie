//
//  XMGTopicPictureView.m
//  BaiSi
//
//  Created by Yang on 2017/5/4.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGTopicPictureView.h"
#import "XMGTopic.h"
#import <SDWebImage/UIImage+GIF.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import <FLAnimatedImage/FLAnimatedImage.h>
#import "UIImageView+Download.h"
#import "XMGSeeBigPictureViewController.h"


@interface XMGTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *zhanweiImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seePictureBtn;



@end

@implementation XMGTopicPictureView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled =  YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPic)]];
}
//监听方法点击  查看大图
-(void)seeBigPic{
    XMGSeeBigPictureViewController * vc = [[XMGSeeBigPictureViewController alloc] init];
    vc.topic = self.topic;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}
- (void)setTopic:(XMGTopic *)topic
{
    _topic = topic;
    self.zhanweiImageView.hidden = NO;
    //是否显示gif标志
    self.gifView.hidden = !topic.is_gif;
    //设置图片
    [self.imageView xmg_setOriginImageWithURL:topic.image1 andThumbnailImageWithURL:topic.image0 placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(!image) return ;
        self.zhanweiImageView.hidden = YES;
        if(topic.isBigPicture){//下载成功处理图片 //重画图片  等比例伸缩
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = imageW * topic.height / topic.width;
            //开启上文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            //重画图片  滑到刚刚好填充的矩形框
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            //关闭上下文
            UIGraphicsEndImageContext();
        }
    }];
    
    //查看超长大图
    if(topic.isBigPicture){
        self.seePictureBtn.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        //裁剪出超出部分
        self.imageView.clipsToBounds = YES;
    }else{
        self.seePictureBtn.hidden = YES;
        //填充满
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        //裁剪出超出部分
        self.imageView.clipsToBounds = NO;
    }
}
















@end
