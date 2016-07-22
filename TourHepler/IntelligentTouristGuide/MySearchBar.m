//
//  MySearchBar.m
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/21.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MySearchBar.h"
#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)
#define kViewLeftAndRightMargins 5
#define kViewHeight 40
#define kViewAndInput 8
#define kBtnWeight 25

@implementation MySearchBar

- (instancetype)init
{
    self = [super init];
    if (self) {
//        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//        self.frame
//        self.frame = [[UIView alloc]init];
        self.frame = CGRectMake(0, 64, screenWidth, kViewHeight);
        self.backgroundColor = [UIColor whiteColor];
        
        _returnBtn = [[UIButton alloc]init];
        _returnBtn.frame = CGRectMake(5, kViewAndInput, kBtnWeight, kBtnWeight);
        [_returnBtn setBackgroundImage:[UIImage imageNamed:@"旅游助手－搜索.png"] forState:UIControlStateNormal];
//        _returnBtn.backgroundColor = [UIColor redColor];
//        [_returnBtn setTitle:@"搜索" forState:UIControlStateNormal];
        //        _returnBtn.titleLabel.text = @"搜索";
        //        _returnBtn.titleLabel.backgroundColor = [UIColor redColor];
        [_returnBtn addTarget:self action:@selector(returnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _inputTF = [[UITextField alloc]init];
        _inputTF.frame = CGRectMake(kBtnWeight+kViewAndInput,0, self.frame.size.width-kViewAndInput*2-kBtnWeight-5, kViewHeight);
//        _inputTF.backgroundColor = [UIColor grayColor];
        _inputTF.delegate =self;
        _inputTF.placeholder = @"输入搜索内容";
        _inputTF.clearButtonMode = UITextFieldViewModeAlways;
        
        
        [self addSubview:_inputTF];
        [self addSubview:_returnBtn];
    }
    return self;
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
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
