//
//  MySearchBar.h
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/21.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySearchBar : UIView<UITextFieldDelegate>

//@property (nonatomic,strong) UIView *searchBarView;
@property (nonatomic,strong) UITextField *inputTF;
@property (nonatomic,strong) UIButton *returnBtn;

@end
