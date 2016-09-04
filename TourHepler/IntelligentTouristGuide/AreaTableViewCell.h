//
//  AreaTableViewCell.h
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/8/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AreaInfo;
@class AreaViewController;

@protocol AreaTableViewCellDelegate <NSObject>

- (void)BtnClick:(UIButton *)btn;

@end

@interface AreaTableViewCell : UITableViewCell



@property(nonatomic,strong) UIButton* area1;
@property(nonatomic,strong) UIButton* area2;
@property(nonatomic,strong) UIButton* area3;

@property(nonatomic,strong) UIButton* areaName1;
@property(nonatomic,strong) UIButton* areaName2;
@property(nonatomic,strong) UIButton* areaName3;

@property(nonatomic,strong) UIButton* titleBtn;

//@property(nonatomic,strong)AreaViewController *mainVC;


@property (nonatomic,weak) id<AreaTableViewCellDelegate> delegate;

- (void)setCellData:(NSArray*)area sum:(NSInteger)sum;

+ (CGFloat) returnCellHeight;

@end
