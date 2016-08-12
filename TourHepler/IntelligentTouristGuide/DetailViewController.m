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
#define btnH (163.0/1920*h)
#define btnW (335.0/1080*w)


@interface DetailViewController ()<BMKLocationServiceDelegate>

@property (nonatomic,strong) BMKLocationService* locService;
@property(readonly, nonatomic) CLLocationCoordinate2D homeCenterCC2D;
//@property(nonatomic,strong) NSString *star;
@property(nonatomic) BOOL isPlaying;


@property(nonatomic) NSInteger sum;

@end

@implementation DetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isPlaying = NO;
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
    
    self.navigationBar.rightBtn.backgroundColor = [UIColor clearColor];
    self.navigationBar.leftBtn.backgroundColor = [UIColor clearColor];
    [self.navigationBar.rightBtn setImage:[UIImage imageNamed:@"旅游助手－播放语音.png"] forState:UIControlStateNormal];
    [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"旅游助手－返回.png"] forState:UIControlStateNormal];
    UIColor *navigationBarColor = [UIColor colorWithWhite:0.6 alpha:0.6];
    self.navigationBar.backgroundColor = navigationBarColor;
    
//    _star = [[NSString alloc]initWithString:self.navigationBar.titleBtn.titleLabel.text];
//    self.navigationBar.titleLabel.text = _titleText;
    
    // 采用本地图片和景点介绍实现
    DataSingleton* dataSL = [DataSingleton shareInstance];
    NSMutableArray *imageNames = [[NSMutableArray alloc]init];
    NSMutableArray *locatianNames = [[NSMutableArray alloc]init];
    int i;
    for (i = 0; i<[dataSL.allDetail count]; i++) {
        Location* tem = [dataSL.allDetail objectAtIndex:i];
//        NSLog(@"%@ %@",self.detailImg ,tem.locationImageName);
        if ([self.detailImg isEqualToString: tem.locationImageName]) {
            break;
        }
    }
    imageNames = [dataSL.allImgWithLocation objectAtIndex:i];
    
    _sum = [imageNames count];
    NSString *display = @"-";
    display=[display stringByAppendingString:[NSString stringWithFormat:@"%d",1]];
    display=[display stringByAppendingString:@"/"];
    display=[display stringByAppendingString:[NSString stringWithFormat:@"%ld",_sum]];
    display=[display stringByAppendingString:@"-"];
    self.navigationBar.titleBtn.titleLabel.font = [UIFont systemFontOfSize:23];
    [self.navigationBar.titleBtn setTitle:display forState:UIControlStateNormal];
    for (int j = 0; j<[imageNames count]; j++) {
        Location* tem = [dataSL.allDetail objectAtIndex:i];
        [locatianNames addObject:tem.locationText];
    }
    
    
    //本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -12, w, h+12) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
//    cycleScrollView.autoScroll = NO;
//    cycleScrollView.showPageControl = NO;
    cycleScrollView.titlesGroup = locatianNames;
    cycleScrollView.titleLabelHeight = (574.0/1920.0)*h;
    cycleScrollView.showPageControl = NO;
    cycleScrollView.imageURLStringsGroup = imageNames;
//    cycleScrollView.autoScroll = YES;
    cycleScrollView.autoScrollTimeInterval = 2.5;
    
    [self.view addSubview:cycleScrollView];
    
//    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    _detailBtn= [[UIButton alloc]initWithFrame:CGRectMake(w-btnW, h-btnH, btnW, btnH)];
    [_detailBtn setBackgroundImage:[UIImage imageNamed:@"旅游助手－现在就去玩.png"] forState:UIControlStateNormal];
//    [_detailBtn setTitle:@"我要到这里去" forState:UIControlStateNormal];
    [_detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_detailBtn];
    [self.view addSubview:self.navigationBar];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    NSString *display = @"-";
    display=[display stringByAppendingString:[NSString stringWithFormat:@"%ld",index+1]];
    display=[display stringByAppendingString:@"/"];
    display=[display stringByAppendingString:[NSString stringWithFormat:@"%ld",_sum]];
    display=[display stringByAppendingString:@"-"];
    [self.navigationBar.titleBtn setTitle:display forState:UIControlStateNormal];
//    self.navigationBar.titleBtn.titleLabel.text = display;
//    NSLog(@"%ld",(long)index);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
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
    DataSingleton *dataSL = [DataSingleton shareInstance];
    start.name = dataSL.title;
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
    
    [BMKOpenRoute openBaiduMapWalkingRoute:opt];
//    NSLog(@"%d", code);
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
//    NSLog(@"buffer progress %2d%%. msg: %@.", progress, msg);
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
//    NSLog(@"speak progress %2d%%.", progress);
}

- (void) onCompleted:(IFlySpeechError *)error{
    [_iFlySpeechSynthesizer stopSpeaking];
    [self.navigationBar.rightBtn setImage:[UIImage imageNamed:@"旅游助手－播放语音.png"] forState:UIControlStateNormal];
    _isPlaying = NO;
    
}

- (void)rightBtnDidClick:(UIButton *)rightBtn{
    if (!_isPlaying) {
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
        
        [self.navigationBar.rightBtn setImage:[UIImage imageNamed:@"54C5D57F9705BCC1D0486DB7D059E2E3.png"] forState:UIControlStateNormal];
        
    }else{
        [self.navigationBar.rightBtn setImage:[UIImage imageNamed:@"旅游助手－播放语音.png"] forState:UIControlStateNormal];
        [_iFlySpeechSynthesizer stopSpeaking];
    }
    _isPlaying^=1;
    
}

- (void)leftBtnDidClick:(UIButton *)leftBtn{
//    NSLog(@"Detail leftBtnClick");
    if (_state==Playing) {
        [_iFlySpeechSynthesizer stopSpeaking];
        _state = NotStart;
    }
    _iFlySpeechSynthesizer.delegate = nil;
    if([self.navigationController popViewControllerAnimated:YES])
        ;
    else
        [self dismissViewControllerAnimated:YES completion:nil];
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
