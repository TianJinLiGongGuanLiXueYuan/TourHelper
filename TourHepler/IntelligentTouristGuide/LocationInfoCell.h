//
//  LocationInfoCell.h
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
@interface LocationInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locationImage;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

- (IBAction)imageBtnClick:(id)sender;
- (void)setCellData:(Location*)location;

@property (nonatomic, copy) void(^imageViewClickBlock)(UIButton *btn,NSString *str);

@end
