//
//  LocationInfoCell.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "LocationInfoCell.h"
#import "DetailViewController.h"

@interface LocationInfoCell ()

@property (strong, nonatomic) Location *currentLocation;
@property (strong, nonatomic) DetailViewController *detailViewController;

@end

@implementation LocationInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)voiceBtnClick:(id)sender {
    //1.创建合成对象
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance]; _iFlySpeechSynthesizer.delegate =
    self;
    
    //设置在线工作方式
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                  forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //音量,取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]]; //发音人,默认为”xiaoyan”,可以设置的参数列表可参考“合成发音人列表” [_iFlySpeechSynthesizer setParameter:@" xiaoyan " forKey: [IFlySpeechConstant VOICE_NAME]]; //保存合成文件名,如不再需要,设置设置为nil或者为空表示取消,默认目录位于 library/cache下
    [_iFlySpeechSynthesizer setParameter:@" tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    //3.启动合成会话
//    [IFlySpeechUtility createUtility:@"你好,我是科大讯飞的小燕"];
    [_iFlySpeechSynthesizer startSpeaking: self.currentLocation.locationText];

    
}

- (IBAction)imageBtnClick:(id)sender {
    self.imageViewClickBlock((UIButton *)sender,[NSString stringWithString:_locationNameLabel.text],[NSString stringWithString:_imgName],[NSString stringWithString:_cellText]);
    
}

- (void)setCellData:(Location*)location{
    self.currentLocation = location;
    [self.locationImage setImage:[UIImage imageNamed:location.locationImageName]];
    
    self.imgName = location.locationImageName;
    self.cellText = location.locationText;
    self.locationNameLabel.text = self.currentLocation.locationName;
    self.distanceLabel.text = self.currentLocation.distance;
}

@end
