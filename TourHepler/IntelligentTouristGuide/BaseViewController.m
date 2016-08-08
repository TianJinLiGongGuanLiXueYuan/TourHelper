//
//  BaseViewController.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       
    
    [self.view addSubview:self.navigationBar];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)leftBtnDidClick:(UIButton *)leftBtn{
//    NSLog(@"leftBtnDidClick");
}
- (void)rightBtnDidClick:(UIButton *)rightBtn{
//    NSLog(@"rightBtnDidClick");
}
- (CustomNavigationBar *)navigationBar{
    if (_navigationBar==Nil) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        _navigationBar = [[CustomNavigationBar alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 64)];
        _navigationBar.delegate = self;
    }
    return _navigationBar;
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
