//
//  MySearchBar.h
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/21.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MySearchBarDelegate <NSObject>

- (void)locationBtnClick:(UIButton *)btn;
- (void)wcBtnClick:(UIButton *)btn;
- (void)foodBtnClick:(UIButton *)btn;
- (void)returnBtnClick:(UIButton*)btn;

@end


@interface MySearchBar : UIView<UITextFieldDelegate>

//@property (nonatomic,strong) UIView *searchBarView;
//@property (nonatomic,strong) UITextField *inputTF;
//@property (nonatomic,strong) UIButton *returnBtn;
@property (nonatomic,strong) UIButton *locationBtn;
@property (nonatomic,strong) UIButton *wcBtn;
@property (nonatomic,strong) UIButton *foodBtn;
@property (nonatomic,weak) id<MySearchBarDelegate> delegate;




@end
