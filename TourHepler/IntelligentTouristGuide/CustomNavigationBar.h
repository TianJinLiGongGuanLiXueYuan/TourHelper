//
//  CustomNavigationBar.h
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomNavigationBarDelegate <NSObject>

- (void)leftBtnDidClick:(UIButton *)leftBtn;
- (void)rightBtnDidClick:(UIButton *)rightBtn;

@end


@interface CustomNavigationBar : UIView

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,weak) id<CustomNavigationBarDelegate> delegate;


@end
