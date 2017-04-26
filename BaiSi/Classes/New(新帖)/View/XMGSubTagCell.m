//
//  XMGSubTagCell.m
//  BaiSi
//
//  Created by Yang on 2017/4/23.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGSubTagCell.h"
#import "XMGSubTagItem.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface XMGSubTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;

@end

@implementation XMGSubTagCell
-(void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}
//从xib中加载就会调用一次
- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconView.layer.cornerRadius = self.iconView.frame.size.width/2;
    self.iconView.layer.masksToBounds = YES;
    //self.layoutMargins = UIEdgeInsetsZero;
}

-(void)setItem:(XMGSubTagItem *)item{
    _item = item;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameView.text = item.theme_name;
    NSString * numStr = [NSString stringWithFormat:@"%@人订阅",item.sub_number];
    NSInteger num = item.sub_number.integerValue;
    if(num>10000){
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numF];
        numStr =[numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    self.numView.text = numStr;
}

@end
