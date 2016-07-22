//
//  AlertView.h
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/17.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIActivityIndicatorView *aiv;
@property (nonatomic, strong) UIView*  ParentView;
@property (nonatomic, assign) int queueCount;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setText:(NSString *) text;

- (void)show;

- (void)hide;


@end
