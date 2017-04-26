//
//  XMGLoginRegisterViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/24.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGLoginRegisterViewController.h"
#import "XMGLoginRegistrView.h"
#import "XMGFastLogin.h"
@interface XMGLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadConstents;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation XMGLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XMGLoginRegistrView *log = [XMGLoginRegistrView loginView];
    
    [self.middleView addSubview:log];
    
    XMGLoginRegistrView *reg = [XMGLoginRegistrView registerView];
    reg.xmg_x = self.middleView.xmg_width * 0.5;
    
    [self.middleView addSubview:reg];
    XMGFastLogin * flog = [XMGFastLogin fastLogin];
    [self.bottomView addSubview:flog];
}

//文本框光标变成白色  

//开发中一般在ViewDidLayoutSubviews设置frame
-(void)ViewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    XMGLoginRegistrView *log = self.middleView.subviews[0];
    XMGLoginRegistrView *reg = self.middleView.subviews[1];
    XMGFastLogin * flog = self.bottomView.subviews[0];
    log.frame = CGRectMake(0, 0, self.middleView.xmg_width*0.5, self.middleView.xmg_height);
    reg.frame = CGRectMake(self.middleView.xmg_width * 0.5, 0, self.middleView.xmg_width*0.5, self.middleView.xmg_height);
    flog.frame = CGRectMake(0, 0, self.bottomView.xmg_width, self.bottomView.xmg_height);
  
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
    //平移中间的View
    if(sender.selected){
        self.leadConstents.constant = -self.middleView.xmg_width * 0.5;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    }else{
        self.leadConstents.constant = 0;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

@end
