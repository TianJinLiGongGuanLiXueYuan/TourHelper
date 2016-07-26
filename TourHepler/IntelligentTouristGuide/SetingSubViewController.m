//
//  SetingSubViewController.m
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/25.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "SetingSubViewController.h"
#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)
#define kViewLeftAndRightMargins 5
#define kViewHeight (1.0/3.0*screenHeight)
#define kViewAndInput 8
#define kBtnWeight (1.0/3.0*screenWidth)
#define kBtnHeight (30)

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
    [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"旅游助手－返回.png"] forState:UIControlStateNormal];
    [self.navigationBar.rightBtn setHidden:YES];
    
    UIColor *Color = [UIColor colorWithRed:35.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1];
    self.view.backgroundColor = Color;
    
//    SetingSubView * setingSubView = [[SetingSubView alloc]init];
//    [self.view addSubview:setingSubView];
    
//    self.frame = CGRectMake(0, 64, screenWidth, kViewHeight);
//    UIColor *Color = [UIColor colorWithRed:35.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1];
//    self.backgroundColor = Color;
    
    _inputTF = [[UITextField alloc]init];
    _inputTF.frame = CGRectMake(kViewLeftAndRightMargins,64+kViewLeftAndRightMargins, screenWidth-kViewLeftAndRightMargins*2, kViewHeight);
    _inputTF.backgroundColor = [UIColor whiteColor];
    _inputTF.delegate =self;
    _inputTF.placeholder = @"提出您的意见";
    _inputTF.clearButtonMode = UITextFieldViewModeAlways;
    
    
    _returnBtn = [[UIButton alloc]init];
    _returnBtn.frame = CGRectMake(kBtnWeight, screenHeight-kViewHeight, kBtnWeight, kBtnHeight);
    _returnBtn.backgroundColor = [UIColor grayColor];
    [_returnBtn setTitle:@"提交" forState:UIControlStateNormal];
    _returnBtn.titleLabel.textColor = [UIColor whiteColor];
    
    _returnBtn.layer.masksToBounds = YES;
    _returnBtn.layer.cornerRadius = 6.0;
    _returnBtn.layer.borderWidth = 1.0;
    
    [_returnBtn addTarget:self action:@selector(returnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_inputTF];
    [self.view addSubview:_returnBtn];
    
}

#pragma  mark- 通过委托放弃第一响应者

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)returnBtnClick:(UIButton*)sender{
    //    self.inputTF.showsScopeBar = NO;
    //    [self.searchBar sizeToFit];
    [self.inputTF resignFirstResponder];
//    NSLog(@"returnBtn 点击");
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"提交成功，谢谢您！"
                              delegate:nil
                              cancelButtonTitle:@"关闭"
                              otherButtonTitles:nil
                              ];
    //
    [alertView show];
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
