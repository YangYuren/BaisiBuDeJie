//
//  XMGTopicCell.m
//  BaiSi
//
//  Created by Yang on 2017/5/2.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGTopicCell.h"
#import "XMGTopic.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "XMGTopicVideoView.h"
#import "XMGTopicVoiceView.h"
#import "XMGTopicPictureView.h"

@interface XMGTopicCell()
// 控件的命名 -> 功能 + 控件类型
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;

//中间控件
@property(nonatomic,weak)XMGTopicPictureView * pictureView;
@property(nonatomic,weak)XMGTopicVoiceView * voiceView;
@property(nonatomic,weak)XMGTopicVideoView * videoView;

@end

@implementation XMGTopicCell
#pragma mark - 懒加载
-(XMGTopicPictureView *)pictureView{
    if(_pictureView == nil){
        XMGTopicPictureView * pictureView = [XMGTopicPictureView xmg_viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
-(XMGTopicVoiceView *)voiceView{
    if(_voiceView == nil){
        XMGTopicVoiceView * voiceView = [XMGTopicVoiceView xmg_viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
-(XMGTopicVideoView *)videoView{
    if(_videoView == nil){
        XMGTopicVideoView * videoView = [XMGTopicVideoView xmg_viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
#pragma mark - 只加载一次
-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

-(void)setTopic:(XMGTopic *)topic{
    _topic = topic;
    //顶部控件数据
    UIImage * placeHolder = [UIImage imageNamed:@"defaultUserIcon"];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[placeHolder circleImage] options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.profileImageView.image = [image circleImage];
    }];
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    
    // 底部按钮的文字
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    
    //最热评论
    if(topic.top_cmt.count){
        //有最热评论
        self.topCmtView.hidden = NO;
        NSDictionary *cmt = topic.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if(content.length==0){
            content = @"[语音评论]";
        }
        NSString * username = cmt[@"user"][@"username"];
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@:%@",username,content];
    }else{
        //没有最热评论
        self.topCmtView.hidden = YES;
    }
    //中间内容(防止cell循环使用 造成一些控件错乱)
    if(topic.type == XMGTopicTypePicture){
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if(topic.type ==XMGTopicTypeVoice){
        self.voiceView.hidden = NO;
        //传值
        self.voiceView.topic = topic;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }else if(topic.type ==XMGTopicTypeVideo){
        self.videoView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }else{
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
}
-(void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)palceholder{
    if(number>10000){
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number/10000.0] forState:UIControlStateNormal];
    }else if(number>0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        [button setTitle:palceholder forState:UIControlStateNormal];
    }
}
-(void)setFrame:(CGRect)frame{
    frame.size.height -=10;
    [super setFrame:frame];
}
//设置控件的Frame
-(void)layoutSubviews{
    [super layoutSubviews];
    if(self.topic.type == XMGTopicTypePicture){
        self.pictureView.frame = self.topic.middleFrame;
    }else if(self.topic.type ==XMGTopicTypeVoice){
        self.voiceView.frame = self.topic.middleFrame;
    }else if(self.topic.type ==XMGTopicTypeVideo){
        self.videoView.frame = self.topic.middleFrame;
    }
    
    
}








@end
