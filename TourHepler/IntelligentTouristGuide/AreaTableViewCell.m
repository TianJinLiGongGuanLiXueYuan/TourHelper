//
//  AreaTableViewCell.m
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/8/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "AreaTableViewCell.h"
#import "AreaInfo.h"
#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)
#define kBtnWeight (screenWidth*1.0/4.0)
#define kMargins (screenWidth/16.0)
#define kStrHeight (20)
#define kBtnAndName (0)


@implementation AreaTableViewCell



- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleBtn = [[UIButton alloc]init];
        _area1 = [[UIButton alloc]init];
        _area2 = [[UIButton alloc]init];
        _area3 = [[UIButton alloc]init];
        
        _areaName1 = [[UIButton alloc]init];
        _areaName2 = [[UIButton alloc]init];
        _areaName3 = [[UIButton alloc]init];
        
        _area1.frame = CGRectMake(kMargins, kMargins, kBtnWeight, kBtnWeight);
        _areaName1.frame = CGRectMake(kMargins, kMargins+kBtnWeight+kBtnAndName, kBtnWeight, kStrHeight);
        _area1.backgroundColor = [UIColor redColor];
        _area2.frame = CGRectMake(kMargins*2+kBtnWeight, kMargins, kBtnWeight, kBtnWeight);
        _areaName2.frame = CGRectMake(kMargins+kBtnWeight+kMargins, kMargins+kBtnWeight+kBtnAndName, kBtnWeight, kStrHeight);
        _area2.backgroundColor = [UIColor greenColor];
        _area3.frame = CGRectMake(kMargins*3+kBtnWeight*2, kMargins, kBtnWeight, kBtnWeight);
        _areaName3.frame = CGRectMake(kMargins+kBtnWeight+kMargins+kBtnWeight+kMargins, kMargins+kBtnWeight+kBtnAndName, kBtnWeight, kStrHeight);
        _area3.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat) returnCellHeight{
    return kMargins+kBtnWeight+kBtnAndName+kStrHeight;
}


- (void)setCellData:(NSArray*)area sum:(NSInteger)sum{
    if (area==nil) {
        return;
    }
    if (sum==1) {
        [_areaName1 setTitle:area[0] forState:UIControlStateNormal];
        [_areaName1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        [self.contentView addSubview:_area1];
        
        [self.contentView addSubview:_areaName1];
    }
    
    if(sum==2) {
        [_areaName1 setTitle:area[0] forState:UIControlStateNormal];
        [_areaName1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [_areaName2 setTitle:area[1] forState:UIControlStateNormal];
        [_areaName2 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        [self.contentView addSubview:_area1];
        [self.contentView addSubview:_area2];
        
        [self.contentView addSubview:_areaName1];
        [self.contentView addSubview:_areaName2];
    }
    
    if (sum==3) {
        [_areaName1 setTitle:area[0] forState:UIControlStateNormal];
        [_areaName1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [_areaName2 setTitle:area[1] forState:UIControlStateNormal];
        [_areaName2 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [_areaName3 setTitle:area[2] forState:UIControlStateNormal];
        [_areaName3 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        
        [self.contentView addSubview:_area1];
        [self.contentView addSubview:_area2];
        [self.contentView addSubview:_area3];
        
        [self.contentView addSubview:_areaName1];
        [self.contentView addSubview:_areaName2];
        [self.contentView addSubview:_areaName3];
    }
    
    
    
    
    
    
}

@end
