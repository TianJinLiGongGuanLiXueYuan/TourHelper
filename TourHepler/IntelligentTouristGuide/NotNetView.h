//
//  NotNetView.h
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/8/6.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NotNetViewDelegate <NSObject>

- (void)updataBtnClick:(UIButton *)btn;

@end


@interface NotNetView : UIView

@property (nonatomic,strong)UIButton *updataBtn;
@property (nonatomic,strong)UIButton *infoBtn;
@property (nonatomic,strong)UILabel *infoLabel;
@property (nonatomic,weak) id<NotNetViewDelegate> delegate;


@end
