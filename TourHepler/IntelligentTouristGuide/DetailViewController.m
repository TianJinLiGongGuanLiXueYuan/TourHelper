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
//    self.navigationBar.titleLabel.text = self.titleText;
    [self.navigationBar.rightBtn setImage:[UIImage imageNamed:@"语音.ico"] forState:UIControlStateNormal];
//    self.navigationBar.backgroundColor = [UIColor clearColor];
//    UIImageView *locationImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 414, 300)];
//    [locationImg setImage:[UIImage imageNamed:self.detailImg]];
//    locationImg.backgroundColor = [UIColor redColor];
//    [self.view addSubview:locationImg];
    
    UITextView *locationTV = [[UITextView alloc]initWithFrame:CGRectMake(0,300+64+64, 414, 280)];
    locationTV.text = self.detailText;
    [locationTV setEditable:NO];
    locationTV.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:locationTV];
    
    
    
    
    [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"homeNabigationLeftIcon.ico"] forState:UIControlStateNormal];
//    [self.navigationBar.rightBtn setImage:[UIImage imageNamed:@"homeNabigationRightIcon.ico"] forState:UIControlStateNormal];
    
    
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
    
//    for (Location* obj in dataSL.allDetail) {
//        [imageNames addObject:obj.locationImageName];
//    }
//    NSLog(@"%@",imageNames);
//    NSArray *imageNames = @[@"h1.jpg",
//                            @"h2.jpg",
//                            @"h3.jpg",
//                            @"h4.jpg",
//                            @"h7" // 本地图片请填写全名
//                            ];
    // 情景二：采用网络图片实现
//    NSArray *imagesURLStrings = @[
//                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
//                                  ];
//    
//    // 情景三：图片配文字
//    NSArray *titles = @[@"新建交流QQ群：185534916 ",
//                        @"感谢您的支持，如果下载的",
//                        @"如果代码在使用过程中出现问题",
//                        @"您可以发邮件到gsdios@126.com"
//                        ];
    
    
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
//    detailBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:detailBtn];
//    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    
//    // 网络加载 --- 创建带标题的图片轮播器
//    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 280, w, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    
//    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    cycleScrollView2.titlesGroup = titles;
//    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
//    [self.view addSubview:cycleScrollView2];
//    
//    //         --- 模拟加载延迟
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
//    });
//    
}

//- (NSString*)labelStringToTextString(NSString*){
//    NSString* ans = [[NSString alloc]init];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //    [IFlySpeechUtility createUtility:@"你好,我是科大讯飞的小燕"];
    [_iFlySpeechSynthesizer startSpeaking: self.detailText];
}

- (void)leftBtnDidClick:(UIButton *)leftBtn{
//    NSLog(@"Detail leftBtnClick");
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
