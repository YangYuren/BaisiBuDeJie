//
//  XMGTopic.m
//  BaiSi
//
//  Created by Yang on 2017/4/28.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGTopic.h"

@implementation XMGTopic
//计算cell的高度
-(CGFloat)cellHeight{
    //如果已经计算过  就直接返回
    if(_cellHeight) return _cellHeight;
    
    //文字的y值
    _cellHeight +=55;
    //文字高度
    CGSize textMaxSize = CGSizeMake(XMGScreenW-2*10, MAXFLOAT);
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    CGRect rect=[self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    _cellHeight += rect.size.height+10;
    
    //中间内容
    if(self.type != XMGTopicTypeWord){//(图片 声音 视频)
        CGFloat  middleW = textMaxSize.width;
        CGFloat  middleH = middleW * self.height /self.width;
        CGFloat  middleY = _cellHeight;
        CGFloat  middleX = 10;
        //有先后顺序
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellHeight += middleH+10;
    }
    
    //最热评论
    if(self.top_cmt.count){
        _cellHeight +=21;
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if(content.length==0){
            content = @"[语音评论]";
        }
        NSString * username = cmt[@"user"][@"username"];
        NSString * str= [NSString stringWithFormat:@"%@:%@",username,content];
        _cellHeight +=[str boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height+10;
    }
    
    //工具条高度
    _cellHeight +=35+10;
    return _cellHeight;
}
@end
