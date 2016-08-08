//
//  NotNetView.m
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/8/6.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "NotNetView.h"
#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)
#define infoBtnWidth (160)
#define infoBtnHeight (160)
#define updataBtnWidth (160)
#define updataBtnHeight (40)
#define kk (6.0)


@implementation NotNetView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, screenWidth, screenHeight-64);
        self.backgroundColor = [UIColor colorWithWhite:0.630 alpha:1.000];
        
        [self addSubview:self.infoBtn];
        
        [self addSubview:self.infoLabel];
        
        [self addSubview:self.updataBtn];
        
    }
    return self;
}


- (UIButton *)infoBtn{
    if (_infoBtn==nil) {
        _infoBtn = [[UIButton alloc]init];
        _infoBtn.frame = CGRectMake((screenWidth-infoBtnWidth)/2.0, screenHeight/kk, infoBtnWidth, infoBtnHeight);
        [_infoBtn setImage:[UIImage imageNamed:@"警告.png"] forState:UIControlStateNormal];
    }
    return _infoBtn;
}


- (UILabel*)infoLabel{
    if (_infoLabel==nil) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.frame = CGRectMake((screenWidth-infoBtnWidth)/2.0, screenHeight/kk+infoBtnHeight+10, updataBtnWidth, updataBtnHeight);
        _infoLabel.text = @"无网络";
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _infoLabel;
}


- (UIButton *)updataBtn{
    if (_updataBtn==nil) {
        _updataBtn = [[UIButton alloc]init];
        _updataBtn.frame = CGRectMake((screenWidth-updataBtnWidth)/2.0, screenHeight/kk+infoBtnHeight+10+updataBtnHeight+10, updataBtnWidth, updataBtnHeight);
        _updataBtn.backgroundColor = [UIColor clearColor];
        [_updataBtn setTitle:@"点击刷新" forState:UIControlStateNormal];
        _updataBtn.layer.masksToBounds = YES;
        _updataBtn.layer.cornerRadius = 6.0;
        _updataBtn.layer.borderWidth = 1.0;
        _updataBtn.layer.borderColor = [UIColor blackColor].CGColor;
        [_updataBtn addTarget:self action:@selector(updataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updataBtn;
}

- (void)updataBtnClick:(UIButton *)btn{
    [self.delegate updataBtnClick:btn];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
