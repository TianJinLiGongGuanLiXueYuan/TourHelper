//
//  MapViewController.h
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/14.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeViewController.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface MapViewController : BaseViewController<BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate,BMKMapViewDelegate>

@property (nonatomic,strong) NSString* titleText;
@property (nonatomic,strong) BMKPoiSearch* searcher;
@property (nonatomic,strong) BMKUserLocation *userLocation; //定位功能
@property (nonatomic,strong) BMKLocationService* locService;
@property (nonatomic,strong) BMKMapView* mapView;
@property (nonatomic,strong) BMKGeoCodeSearch* geoCodeSearch;

@end
