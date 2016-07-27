//
//  MapUpView.h
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/22.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

//#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

//#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

//#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

//#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

//#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

//#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface MapUpView : UIView

@property(nonatomic,strong) UILabel *locationNameLabel;
@property(nonatomic,strong) UIImageView *leftImg;
@property(nonatomic,strong) UILabel *distanceLabel;
@property(nonatomic,strong) UIButton *goToBtn;

@property(nonatomic) CLLocationCoordinate2D ownLocation;
@property(nonatomic) CLLocationCoordinate2D goToLocation;
@property(nonatomic,strong) NSString *title;

- (void) getDataWithOwnLocation:(CLLocationCoordinate2D)mapPoint;

- (void) getDataWithGoToLocation:(CLLocationCoordinate2D)mapPoint;


@end
