//
//  XMGLoginRegistrView.m
//  BaiSi
//
//  Created by Yang on 2017/4/24.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGLoginRegistrView.h"

@interface XMGLoginRegistrView()
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;

@end



@implementation XMGLoginRegistrView

+(instancetype)loginView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XMGLoginRegistrView class]) owner:nil options:nil] firstObject];
}
+(instancetype)registerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XMGLoginRegistrView class]) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib{
    //让按钮背景图片不被拉伸
    [super awakeFromNib];
    UIImage * image = self.loginRegisterBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    [self.loginRegisterBtn setBackgroundImage:image forState:UIControlStateNormal];
}
@end
