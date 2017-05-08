//
//  XMGTopicVideoView.m
//  BaiSi
//
//  Created by Yang on 2017/5/4.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGTopicVideoView.h"
#import "XMGTopic.h"
#import "UIImageView+Download.h"
#import "XMGSeeBigPictureViewController.h"
@interface XMGTopicVideoView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *zhanweiImageView;

@end
@implementation XMGTopicVideoView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
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
    //设置图片
    [self.imageView xmg_setOriginImageWithURL:topic.image1 andThumbnailImageWithURL:topic.image0 placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(!image) return ;
        self.zhanweiImageView.hidden = YES;
    }];
    
    // 播放数量
    if (topic.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万播放", topic.playcount / 10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    }
    // %04d : 占据4位，多余的空位用0填补   时长
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.videotime / 60, topic.videotime % 60];
}
@end
