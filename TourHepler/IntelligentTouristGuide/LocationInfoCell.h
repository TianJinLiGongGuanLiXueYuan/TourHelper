//
//  LocationInfoCell.h
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import <QuartzCore/QuartzCore.h>

@protocol LocationInfoCellDelegate <NSObject>


@end


@interface LocationInfoCell : UITableViewCell<IFlySpeechSynthesizerDelegate>{
    IFlySpeechSynthesizer * _iFlySpeechSynthesizer;
}
@property (weak, nonatomic) IBOutlet UIButton *UIImgBtn;

@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locationImage;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
- (IBAction)voiceBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (nonatomic,strong) NSString *cellText;
@property (nonatomic,strong) NSString *imgName;
@property (nonatomic) CGFloat cellHeight;
@property (weak, nonatomic) IBOutlet UIView *upBarView;


@property (weak, nonatomic) IBOutlet UIImageView *rightWithBarImg;

- (IBAction)imageBtnClick:(id)sender;
- (void)setCellData:(Location*)location;

+ (CGFloat) returnCellHeight;

@property (nonatomic, copy) void(^imageViewClickBlock)(UIButton *btn,NSString *locationName,NSString* img,NSString* locationText);

@end
