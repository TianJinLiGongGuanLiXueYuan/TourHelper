//
//  SetingSubViewController.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/14.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "SetingSubViewController.h"

@interface SetingSubViewController ()

@end

@implementation SetingSubViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationBar.titleLabel.text = @"提出意见";
    [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"homeNabigationLeftIcon.ico"] forState:UIControlStateNormal];
    [self.navigationBar.rightBtn setHidden:YES];
    
    
    UITextView *subTV = [[UITextView alloc]initWithFrame:CGRectMake(0,64+5, 410, 280)];
    subTV.text = @"请写下您的意见";
    subTV.font = [UIFont boldSystemFontOfSize:15];
    subTV.layer.borderColor =(__bridge CGColorRef _Nullable)([UIColor redColor]);
    subTV.layer.borderWidth =1.0;
    subTV.layer.cornerRadius =5.0;
    [self.view addSubview:subTV];
    
    UIButton *aboutBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 64+5+280+40, 414-200, 40)];
    [aboutBtn setTitle:@"提交" forState:UIControlStateNormal];
    aboutBtn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:aboutBtn];
    
    
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
