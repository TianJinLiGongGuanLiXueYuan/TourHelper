//
//  SetingViewController.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/14.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "SetingViewController.h"

@interface SetingViewController ()

@end

@implementation SetingViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.navigationController setNavigationBarHidden:YES];
        self.navigationBar.titleLabel.text = @"个人设置";
        [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
        [self.navigationBar.rightBtn setHidden:YES];
        
        UIButton *cleanBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 64+100, 414, 40)];
        [cleanBtn setTitle:@"清除缓存" forState:UIControlStateNormal];
        cleanBtn.backgroundColor = [UIColor greenColor];
        [self.view addSubview:cleanBtn];
        
        UIButton *subBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 64+100+40+15, 414, 40)];
        [subBtn setTitle:@"提出意见" forState:UIControlStateNormal];
        subBtn.backgroundColor = [UIColor blueColor];
        [subBtn addTarget:self action:@selector(subBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:subBtn];
        
        
        UIButton *aboutBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 64+100+40+15+40+15, 414, 40)];
        [aboutBtn setTitle:@"关于我们" forState:UIControlStateNormal];
        aboutBtn.backgroundColor = [UIColor redColor];
        [aboutBtn addTarget:self action:@selector(aboutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:aboutBtn];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)aboutBtnClick:(UIButton*)sender{
    SetingAboutViewController *aboutVC = [[SetingAboutViewController alloc]init];
    [self.navigationController pushViewController:aboutVC animated:YES ];
}

- (void)subBtnClick:(UIButton*)sender{
    SetingSubViewController * subVC = [[SetingSubViewController alloc]init];
    [self.navigationController pushViewController:subVC animated:YES ];
}

- (void)leftBtnDidClick:(UIButton *)leftBtn{
//    NSLog(@"leftBtnDidClick");
    [self.navigationController popViewControllerAnimated:YES];
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
