//
//  HomeViewController.h
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BaseViewController.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface HomeViewController : BaseViewController<IFlySpeechSynthesizerDelegate>{


    
    IFlySpeechSynthesizer * _iFlySpeechSynthesizer;
}


//typedef NS_OPTIONS(NSInteger, Status) {
//    NotStart            = 0,
//    Playing             = 2, //高异常分析需要的级别
//    Paused              = 4,
//};

//@property (nonatomic, assign) Status state;

@end
