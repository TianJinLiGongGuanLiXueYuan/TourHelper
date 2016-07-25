//
//  SetingSubViewController.h
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/25.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BaseViewController.h"
//#import "SetingSubView.h"

@interface SetingSubViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *inputTF;
@property (nonatomic,strong) UIButton *returnBtn;

@end
