//
//  DetailViewController.h
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/14.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BaseViewController.h"
#import "Detail.h"
#import "DetailUIView.h"
#import "SDCycleScrollView.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"

@interface DetailViewController : BaseViewController<SDCycleScrollViewDelegate,IFlySpeechSynthesizerDelegate>{
    IFlySpeechSynthesizer * _iFlySpeechSynthesizer;
}



@property (nonatomic,strong) NSString* titleText;
@property(nonatomic,strong) NSString* detailImg;
@property(nonatomic,strong) NSString* detailText;

@end
