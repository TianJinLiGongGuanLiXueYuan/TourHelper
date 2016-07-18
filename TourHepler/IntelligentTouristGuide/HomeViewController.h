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
@end
