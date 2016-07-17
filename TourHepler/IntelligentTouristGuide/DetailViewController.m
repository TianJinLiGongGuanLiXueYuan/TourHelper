//
//  DetailViewController.m
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/14.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "DetailViewController.h"
#import "DataSingleton.h"
#import "Location.h"
#define w [UIScreen mainScreen].bounds.size.width
#define h [UIScreen mainScreen].bounds.size.height

@interface DetailViewController ()



@end

@implementation DetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];

    [self.navigationBar.rightBtn setImage:[UIImage imageNamed:@"语音.ico"] forState:UIControlStateNormal];
    [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"homeNabigationLeftIcon.ico"] forState:UIControlStateNormal];
    
    UITextView *locationTV = [[UITextView alloc]initWithFrame:CGRectMake(0,300+64+64, 414, 280)];
    locationTV.text = self.detailText;
    [locationTV setEditable:NO];
    locationTV.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:locationTV];
    
    // 采用本地图片和景点介绍实现
    DataSingleton* dataSL = [DataSingleton shareInstance];
    NSMutableArray *imageNames = [[NSMutableArray alloc]init];
    NSMutableArray *locatianNames = [[NSMutableArray alloc]init];
    int i;
    for (i = 0; i<[dataSL.allDetail count]; i++) {
        Location* tem = [dataSL.allDetail objectAtIndex:i];
        if (self.detailImg == tem.locationImageName) {
            break;
        }
    }
    
    for (int j = 0; j<[dataSL.allDetail count]; j++) {
        Location* tem = [dataSL.allDetail objectAtIndex:i];
        [imageNames addObject:tem.locationImageName];
        
        [locatianNames addObject:tem.locationText];
        i++;
        i%=[dataSL.allDetail count];
    }
    
     //本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, w, h-64) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleScrollView.autoScroll = NO;
//    cycleScrollView.showPageControl = NO;
    cycleScrollView.titlesGroup = locatianNames;
    cycleScrollView.titleLabelHeight = 300;
    [self.view addSubview:cycleScrollView];
    
    UIButton *detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 64+300+280+10, 414-40, 40)];
    [detailBtn setTitle:@"我要到这里去" forState:UIControlStateNormal];

    [self.view addSubview:detailBtn];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 合成回调 IFlySpeechSynthesizerDelegate

/**
 开始播放回调
 注：
 对通用合成方式有效，
 对uri合成无效
 ****/
- (void)onSpeakBegin
{
    [_inidicateView hide];
    self.isCanceled = NO;
    if (_state  != Playing) {
        [_popUpView showText:@"开始播放"];
    }
    _state = Playing;
}


/**
 缓冲进度回调
 
 progress 缓冲进度
 msg 附加信息
 注：
 对通用合成方式有效，
 对uri合成无效
 ****/
- (void)onBufferProgress:(int) progress message:(NSString *)msg
{
    NSLog(@"buffer progress %2d%%. msg: %@.", progress, msg);
}

/**
 播放进度回调
 
 progress 缓冲进度
 
 注：
 对通用合成方式有效，
 对uri合成无效
 ****/
- (void) onSpeakProgress:(int) progress beginPos:(int)beginPos endPos:(int)endPos
{
    NSLog(@"speak progress %2d%%.", progress);
}


- (void)rightBtnDidClick:(UIButton *)rightBtn{
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
    [_iFlySpeechSynthesizer startSpeaking: self.detailText];
    [_inidicateView setText: @"正在缓冲..."];
    [_inidicateView show];
    [_popUpView removeFromSuperview];
    [_popUpView showText:@"正在缓冲..."];
}

- (void)leftBtnDidClick:(UIButton *)leftBtn{
//    NSLog(@"Detail leftBtnClick");
    if (_state==Playing) {
        [_iFlySpeechSynthesizer stopSpeaking];
        _state = NotStart;
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
