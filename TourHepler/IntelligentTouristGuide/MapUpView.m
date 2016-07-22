//
//  MapUpView.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/22.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MapUpView.h"
#define screenHeight ([UIScreen mainScreen].bounds.size.height)
#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define kUpViewHeight 100
#define kTopMargins 10
#define kLeftAndRightMargins 10
#define klocationNameLabelHeight 30
#define klocationNameLabelWidth 200
#define kgoToBtnLen 80
#define kleftImgLen 20
#define kdistanceLabelWidth  100
#define kdistanceLabelHeight 25

@implementation MapUpView

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.frame = CGRectMake(0, screenHeight-kUpViewHeight,screenWidth, kUpViewHeight);
        self.frame = CGRectMake(0, screenHeight, 0, 0);
        self.backgroundColor = [UIColor whiteColor];
        
        self.goToBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth-kLeftAndRightMargins-kgoToBtnLen, kTopMargins, kgoToBtnLen, kgoToBtnLen)];
        [self.goToBtn setBackgroundImage:[UIImage imageNamed:@"旅游助手－到这去.png"] forState:UIControlStateNormal];
        [self.goToBtn addTarget:self action:@selector(goToBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_goToBtn];
        
        self.locationNameLabel.font = [UIFont systemFontOfSize:20];
        self.locationNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftAndRightMargins, kLeftAndRightMargins, screenWidth-2*kLeftAndRightMargins-kgoToBtnLen, klocationNameLabelHeight)];
        
        [self addSubview:_locationNameLabel];
        
        self.leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(kLeftAndRightMargins, kLeftAndRightMargins*2+klocationNameLabelHeight, kleftImgLen, kleftImgLen)];
        [self.leftImg setImage:[UIImage imageNamed:@"旅游助手－小飞机.png"]];
        [self addSubview:_leftImg];
        
        self.distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftAndRightMargins+kleftImgLen+kLeftAndRightMargins/2.0, kLeftAndRightMargins*2+klocationNameLabelHeight, kdistanceLabelWidth, kdistanceLabelHeight)];
        [self addSubview:_distanceLabel];
        

        
    }
    return self;
}

- (void)goToBtnClick:(UIButton*)sender{
    BMKOpenWalkingRouteOption *opt = [[BMKOpenWalkingRouteOption alloc] init];
    opt.appScheme = @"baidumapsdk://mapsdk.baidu.com";
    //初始化起点节点
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    //指定起点经纬度
    CLLocationCoordinate2D coor1;
    
    coor1.latitude = _ownLocation.latitude;
    coor1.longitude = _ownLocation.longitude;
    
    start.pt = coor1;
    //指定起点名称
    start.name = @"九寨沟";
    //指定起点
    opt.startPoint = start;
    
    //初始化终点节点
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    CLLocationCoordinate2D coor2;
    coor2.latitude = _goToLocation.latitude;
    coor2.longitude = _goToLocation.longitude;
    end.pt = coor2;
    //指定终点名称
    end.name = _locationNameLabel.text;
    opt.endPoint = end;
    
    BMKOpenErrorCode code = [BMKOpenRoute openBaiduMapWalkingRoute:opt];
    NSLog(@"%d", code);
}

- (void) getDataWithOwnLocation:(CLLocationCoordinate2D)mapPoint{
    _ownLocation.latitude = mapPoint.latitude;
    _ownLocation.longitude = mapPoint.longitude;
}

- (void) getDataWithGoToLocation:(CLLocationCoordinate2D)mapPoint{
    _goToLocation.latitude = mapPoint.latitude;
    _goToLocation.longitude = mapPoint.longitude;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
