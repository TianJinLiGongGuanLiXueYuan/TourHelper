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
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#define w [UIScreen mainScreen].bounds.size.width
#define h [UIScreen mainScreen].bounds.size.height

@interface DetailViewController ()<BMKLocationServiceDelegate>

@property (nonatomic,strong) BMKLocationService* locService;
@property(readonly, nonatomic) CLLocationCoordinate2D homeCenterCC2D;

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
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.navigationBar.rightBtn setImage:[UIImage imageNamed:@"语音.ico"] forState:UIControlStateNormal];
    [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"homeNabigationLeftIcon.ico"] forState:UIControlStateNormal];
    
    self.navigationBar.titleLabel.text = _titleText;
    
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
    imageNames = [dataSL.allImgWithLocation objectAtIndex:i];
    
    for (int j = 0; j<[imageNames count]; j++) {
        Location* tem = [dataSL.allDetail objectAtIndex:i];
        [locatianNames addObject:tem.locationText];
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
    
    _detailBtn= [[UIButton alloc]initWithFrame:CGRectMake(20, 64+300+280+10, 414-40, 40)];
    [_detailBtn setTitle:@"我要到这里去" forState:UIControlStateNormal];
    [_detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_detailBtn];
    
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        _homeCenterCC2D.latitude = userLocation.location.coordinate.latitude;
        _homeCenterCC2D.longitude = userLocation.location.coordinate.longitude;
    
    [_locService stopUserLocationService];//取消定位
}

- (void)detailBtnClick:(UIButton*)sender{
    BMKOpenWalkingRouteOption *opt = [[BMKOpenWalkingRouteOption alloc] init];
    opt.appScheme = @"baidumapsdk://mapsdk.baidu.com";
    //初始化起点节点
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    //指定起点经纬度
    CLLocationCoordinate2D coor1;
    
    coor1.latitude = _homeCenterCC2D.latitude;
    coor1.longitude = _homeCenterCC2D.longitude;
    
    start.pt = coor1;
    //指定起点名称
    start.name = @"九寨沟";
    //指定起点
    opt.startPoint = start;
    
    //初始化终点节点
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    CLLocationCoordinate2D coor2;
    coor2.latitude = _endCoor.latitude;
    coor2.longitude = _endCoor.longitude;
    end.pt = coor2;
    //指定终点名称
    end.name = _titleText;
    opt.endPoint = end;
    
    BMKOpenErrorCode code = [BMKOpenRoute openBaiduMapWalkingRoute:opt];
    NSLog(@"%d", code);
    return;
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
