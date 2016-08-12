//
//  CustomNavigationBar.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "CustomNavigationBar.h"
#define ICONSIZE 30
#define TOP 25


@implementation CustomNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor *navigationColor = [UIColor colorWithRed:43.0/255.0 green:162.0/255.0 blue:145.0/255.0 alpha:1];
        self.backgroundColor = navigationColor;
        [self addSubview:self.titleBtn];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.leftClickBtn];
        [self addSubview:self.rightClickBtn];
        self.leftBtn.backgroundColor =navigationColor;
        self.rightBtn.backgroundColor =navigationColor;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.bgImageView.frame = CGRectMake(0, TOP, screenWidth, 30);
    self.titleBtn.frame = CGRectMake(0, TOP, screenWidth, 30);
    //让text居中
//    self.titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.leftBtn.frame = CGRectMake(10, TOP, ICONSIZE, ICONSIZE);
    self.leftClickBtn.frame = CGRectMake(0, 20, self.leftBtn.frame.origin.x+ICONSIZE, 44);
    
    self.rightBtn.frame = CGRectMake((screenWidth-10-ICONSIZE), TOP, ICONSIZE, ICONSIZE);
    self.rightClickBtn.frame = CGRectMake(self.rightBtn.frame.origin.x, 20, screenWidth - self.rightBtn.frame.origin.x, 44);
    
}

- (void)leftBtnClick:(UIButton *)btn
{
    [self.delegate leftBtnDidClick:btn];
}

- (void)rightBtnClick:(UIButton *)btn
{
    [self.delegate rightBtnDidClick:btn];
}



- (UIButton *)titleBtn{
    if (_titleBtn==Nil) {
        _titleBtn = [[UIButton alloc]init];
        _titleBtn.tintColor = [UIColor whiteColor];
    }
    return _titleBtn;
}

- (UIButton *)leftClickBtn{
    if (_leftClickBtn==Nil) {
        _leftClickBtn = [[UIButton alloc]init];
        _leftClickBtn.backgroundColor = [UIColor clearColor];
        [_leftClickBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftClickBtn;
}


- (UIButton *)rightClickBtn{
    if (_rightClickBtn==Nil) {
        _rightClickBtn = [[UIButton alloc]init];
        _rightClickBtn.backgroundColor = [UIColor clearColor];
        [_rightClickBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightClickBtn;
}

- (UIButton *)leftBtn{
    if (_leftBtn==Nil) {
        _leftBtn = [[UIButton alloc]init];
        _leftBtn.backgroundColor = [UIColor whiteColor];
//        [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn{
    if (_rightBtn==Nil) {
        _rightBtn = [[UIButton alloc]init];
        _rightBtn.backgroundColor = [UIColor whiteColor];
//        [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
@end
