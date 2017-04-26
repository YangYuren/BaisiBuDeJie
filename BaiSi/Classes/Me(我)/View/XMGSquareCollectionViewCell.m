//
//  XMGSquareCollectionViewCell.m
//  BaiSi
//
//  Created by Yang on 2017/4/24.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGSquareCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "XMGSquare.h"
@interface XMGSquareCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *iconName;

@end
@implementation XMGSquareCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setSquare:(XMGSquare *)square{
    _square = square;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.square.icon]];
    self.iconName.text = self.square.name;
}
@end
