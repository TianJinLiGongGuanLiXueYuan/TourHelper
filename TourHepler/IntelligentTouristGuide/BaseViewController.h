//
//  BaseViewController.h
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationBar.h"

@interface BaseViewController : UIViewController<CustomNavigationBarDelegate>

@property (nonatomic,strong) CustomNavigationBar* navigationBar;

@end
