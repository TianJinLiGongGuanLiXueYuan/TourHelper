//
//  SetingViewController.h
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/14.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BaseViewController.h"
#import "SetingSubViewController.h"
#import "SetingAboutViewController.h"

@interface SetingViewController : BaseViewController<UIAlertViewDelegate>

+(instancetype) shareInstance;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end
