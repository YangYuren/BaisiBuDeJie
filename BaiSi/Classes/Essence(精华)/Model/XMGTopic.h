//
//  XMGTopic.h
//  BuDeJie
//
//  Created by xiaomage on 16/3/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XMGTopicType) {
    /** 全部 */
    XMGTopicTypeAll = 1,
    /** 图片 */
    XMGTopicTypePicture = 10,
    /** 段子 */
    XMGTopicTypeWord = 29,
    /** 声音 */
    XMGTopicTypeVoice = 31,
    /** 视频 */
    XMGTopicTypeVideo = 41
};

@interface XMGTopic : NSObject
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) NSInteger type;

/** 额外增加的属性 */
@property (nonatomic, assign) CGFloat cellHeight;

//最热评论
@property(nonatomic,strong)NSArray * top_cmt;

//小图  中图  大图
@property(nonatomic,copy)NSString * image0;
@property(nonatomic,copy)NSString * image2;
@property(nonatomic,copy)NSString * image1;

//音频时长
@property(nonatomic,assign)NSInteger voicetime;
//视频时长
@property(nonatomic,assign)NSInteger videotime;
//播放次数
@property(nonatomic,assign)NSInteger playcount;


//图片相关的(高度  宽度)
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;

//图片的frame
@property(nonatomic,assign)CGRect middleFrame;

//是否是动图
@property(nonatomic,assign)BOOL  is_gif;
//是否是超长大图
@property(nonatomic,assign,getter=isBigPicture)BOOL  bigPicture;



@end
