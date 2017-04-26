//
//  XMGEssenceViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/21.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGEssenceViewController.h"

@interface XMGEssenceViewController ()

@end

@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor redColor]];
    
    [self setupNavBar];
}


-(void)setupNavBar{
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage originalImage:@"nav_item_game_icon"] highImage:[UIImage originalImage:@"nav_item_game_click_icon"] Target:self action:@selector(game)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage originalImage:@"navigationButtonRandom"] highImage:[UIImage originalImage:@"navigationButtonRandomClick"] Target:self action:@selector(game)];
}

-(void)game{
    NSLog(@"000");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
