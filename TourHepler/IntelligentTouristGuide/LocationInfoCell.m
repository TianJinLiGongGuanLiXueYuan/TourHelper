//
//  LocationInfoCell.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "LocationInfoCell.h"
#import "DetailViewController.h"
#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)
#define kImgLeftAndRightMargins (28.0/1080.0*screenWidth)
#define kImgTopMargins (27.0/1920.0*screenHeight)
#define kImgHeight (678.0/1920.0*screenHeight)
#define kBarHeight (112.0/1920.0*screenHeight)
#define kImgWithBarMargins (48.0/1920.0*screenHeight)
#define kBarLeftAndRightMargins (19.0/1080.0*screenWidth)
#define kVioceWidth (58.0/1080.0*screenWidth)
#define kVioceHeight (65.0/1920.0*screenHeight)
#define kUpRightImgWidth (48.0/1080.0*screenWidth)

@interface LocationInfoCell ()

@property (strong, nonatomic) Location *currentLocation;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic) BOOL isPlaying;


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
    if (_isPlaying==NO) {
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
        
        [self.voiceBtn setBackgroundImage:[UIImage imageNamed:@"stop27.png"] forState:UIControlStateNormal];
        
    }else{
        [_iFlySpeechSynthesizer stopSpeaking];
        [self.voiceBtn setBackgroundImage:[UIImage imageNamed:@"旅游助手－播放语音.png"] forState:UIControlStateNormal];
    }
    _isPlaying^=1;

    
}

- (IBAction)imageBtnClick:(id)sender {
    
    self.imageViewClickBlock((UIButton *)sender,[NSString stringWithString:_locationNameLabel.text],[NSString stringWithString:_imgName],[NSString stringWithString:_cellText]);
    
}

- (void)setCellData:(Location*)location{
    self.currentLocation = location;
    [self.locationImage setImage:[UIImage imageNamed:location.locationImageName]];
    _isPlaying = NO;
    
    self.imgName = location.locationImageName;
    self.cellText = location.locationText;
    self.locationNameLabel.text = self.currentLocation.locationName;
    self.distanceLabel.text = self.currentLocation.distance;
    UIColor *selfViewColor = [UIColor colorWithRed:35.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1];
    self.backgroundColor = selfViewColor;
    [self layoutSubviews];
    
}

- (void) layoutSubviews{
    [super layoutSubviews];
//    [UIScreen mainScreen].bounds.size.width
//    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.locationImage.frame = CGRectMake(kImgLeftAndRightMargins, kImgTopMargins, screenWidth-2*kImgLeftAndRightMargins, kImgHeight);
    
    self.UIImgBtn.frame = self.locationImage.frame;
//    self.UIImgBtn.backgroundColor = [UIColor redColor];
//    self.UIImgBtn.backgroundColor = [UIColor orangeColor];
    self.upBarView.frame = CGRectMake(kImgLeftAndRightMargins, kImgTopMargins+kImgHeight-30, screenWidth-2*kImgLeftAndRightMargins, kBarHeight+30);
    UIColor *upBarViewColor = [UIColor colorWithRed:43.0/255.0 green:162.0/255.0 blue:145.0/255.0 alpha:1];
    self.upBarView.layer.masksToBounds = YES;
    self.upBarView.layer.cornerRadius = 6.0;
    self.upBarView.layer.borderWidth = 1.0;
    self.upBarView.layer.borderColor = [upBarViewColor CGColor];
    self.upBarView.backgroundColor = upBarViewColor;
    
    
//    self.locationNameLabel.backgroundColor = [UIColor redColor];
    
//    CGSize voiceSize = [self.voiceBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    [self.voiceBtn setBackgroundImage:[UIImage imageNamed:@"旅游助手－播放语音.png"] forState:UIControlStateNormal];
    self.voiceBtn.frame = CGRectMake(kBarLeftAndRightMargins+kImgLeftAndRightMargins, kImgHeight+kImgWithBarMargins,kVioceWidth , kVioceHeight);
//    self.voiceBtn.backgroundColor = [UIColor grayColor];
    
    CGSize locationSize = [self.locationNameLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    self.locationNameLabel.frame = CGRectMake(kBarLeftAndRightMargins+kImgLeftAndRightMargins+kVioceWidth+kBarLeftAndRightMargins, kImgHeight+kImgWithBarMargins, locationSize.width, locationSize.height);
    self.locationNameLabel.backgroundColor = [UIColor clearColor];
    
    CGSize distanceSize = [self.distanceLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    self.distanceLabel.frame = CGRectMake(screenWidth-kImgLeftAndRightMargins*2-kBarLeftAndRightMargins-distanceSize.width, kImgHeight+kImgWithBarMargins, distanceSize.width, distanceSize.height);
//    self.rightWithBarImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"旅游助手－首页下面的地图icon.png"]];
//    [self.rightWithBarImg setBackgroundImage:[UIImage imageNamed:@"旅游助手－首页下面的地图icon.png"] forState:UIControlStateNormal];
    
    self.rightWithBarImg.frame = CGRectMake(screenWidth-kImgLeftAndRightMargins*2-kBarLeftAndRightMargins-kUpRightImgWidth-distanceSize.width, kImgHeight+kImgWithBarMargins, kUpRightImgWidth, distanceSize.height);
//    self.distanceLabel.backgroundColor = [UIColor purpleColor];
}

+ (CGFloat) returnCellHeight{
    return kImgTopMargins+kImgHeight+kBarHeight;
}

@end
