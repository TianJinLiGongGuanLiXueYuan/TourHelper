//
//  MySearchBar.m
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/21.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MySearchBar.h"
#define kViewLeftAndRightMargins 5
#define kViewHeight 50
#define kViewAndInput 5
#define kBtnWeight 50

@implementation MySearchBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//        self.frame
//        self.frame = [[UIView alloc]init];
        self.frame = CGRectMake(kViewLeftAndRightMargins, 64+8, screenWidth-kViewLeftAndRightMargins*2, kViewHeight);
        self.backgroundColor = [UIColor whiteColor];
        
        _inputTF = [[UITextField alloc]init];
        _inputTF.frame = CGRectMake(kViewLeftAndRightMargins+kViewAndInput,kViewAndInput, self.frame.size.width-kViewAndInput*2-kBtnWeight-5, kViewHeight-kViewAndInput*2);
        _inputTF.backgroundColor = [UIColor grayColor];
        _inputTF.delegate =self;
        
        _returnBtn = [[UIButton alloc]init];
        _returnBtn.frame = CGRectMake(self.frame.size.width-kViewAndInput*2-kBtnWeight-5, kViewAndInput, kBtnWeight, _inputTF.frame.size.height);
        _returnBtn.backgroundColor = [UIColor redColor];
        [_returnBtn setTitle:@"搜索" forState:UIControlStateNormal];
//        _returnBtn.titleLabel.text = @"搜索";
//        _returnBtn.titleLabel.backgroundColor = [UIColor redColor];
        [_returnBtn addTarget:self action:@selector(returnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
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
