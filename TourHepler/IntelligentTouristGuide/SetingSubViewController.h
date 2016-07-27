//
//  SetingSubViewController.h
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/25.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BaseViewController.h"
//#import "SetingSubView.h"

@interface SetingSubViewController : BaseViewController<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITextView *inputTV;
@property (nonatomic,strong) UIButton *subBtn;
@property (nonatomic,strong) UIButton *cancelBtn;

@end
