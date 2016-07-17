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
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVAudioSession.h>
#import <AudioToolbox/AudioSession.h>
#import "AlertView.h"
#import "PopupView.h"

@class AlertView;
@class PopupView;

@interface DetailViewController : BaseViewController<SDCycleScrollViewDelegate,IFlySpeechSynthesizerDelegate>{
    IFlySpeechSynthesizer * _iFlySpeechSynthesizer;
}

typedef NS_OPTIONS(NSInteger, Status) {
    NotStart            = 0,
    Playing             = 2, //高异常分析需要的级别
    Paused              = 4,
};

@property (nonatomic,strong) NSString* titleText;
@property(nonatomic,strong) NSString* detailImg;
@property(nonatomic,strong) NSString* detailText;

@property (nonatomic, strong) PopupView *popUpView;
@property (nonatomic, assign) Status state;
@property (nonatomic, strong) AlertView *inidicateView;
@property (nonatomic, assign) BOOL isCanceled;

@end
