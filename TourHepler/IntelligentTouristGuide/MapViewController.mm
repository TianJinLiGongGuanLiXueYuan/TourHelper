//
//  MapViewController.m
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/14.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

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
    self.navigationBar.titleLabel.text = self.titleText;
    [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"homeNabigationLeftIcon.ico"] forState:UIControlStateNormal];
    [self.navigationBar.rightBtn setHidden:YES];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, 414, screenHeight-64)];
    _mapView.delegate = self;
    //[mapView setMapType:BMKMapTypeSatellite];
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.showMapScaleBar = YES;//显示比例尺
    _mapView.zoomLevel=17;//地图显示的级别
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(5, 64+10, screenWidth-10, 40)];
//    searchBar.prompt = @"搜索";
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    _mapView.showsUserLocation = YES;//显示定位图层
    
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    
    _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    //编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
    _geoCodeSearch.delegate = self;//设置代理为self
    
//    [_mapView updateLocationData:_locService.userLocation];
//    CLLocationCoordinate2D tem;
//    tem.latitude = 103.924245;
//    tem.longitude = 33.273342;
//    [_mapView setCenterCoordinate:tem animated:YES];
    
    //普通态
    //以下_mapView为BMKMapView对象
    
//    [mapView updateLocationData:_locService];
    
    [self.view addSubview:_mapView];
    [self.view addSubview:_searchBar];
    [self.view endEditing:YES];
//    
//    //初始化检索对象
//    _searcher =[[BMKPoiSearch alloc]init];
//    _searcher.delegate = self;
//    //发起检索
//    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
//    option.pageIndex = 0;
//    option.pageCapacity = 10;
//    CLLocationCoordinate2D tem;
//    tem.latitude = 39.915;
//    tem.longitude = 116.404;
//    
//    option.location = tem;
//    option.keyword = @"小吃";
//    BOOL flag = [_searcher poiSearchNearBy:option];
////    [option release];
//    if(flag)
//    {
//        NSLog(@"周边检索发送成功");
//    }
//    else
//    {
//        NSLog(@"周边检索发送失败");
//    }
//    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar resignFirstResponder];
}



//点击地图上边的建筑物标记事件
-(void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi{
    CLLocationCoordinate2D coordinate = mapPoi.pt;
    //长按之前删除所有标注
    NSArray *arrayAnmation=[[NSArray alloc] initWithArray:_mapView.annotations];
    [_mapView removeAnnotations:arrayAnmation];
    //设置地图标注
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    [_mapView addAnnotation:annotation];
    BMKReverseGeoCodeOption *re = [[BMKReverseGeoCodeOption alloc] init];
    re.reverseGeoPoint = coordinate;
    [_geoCodeSearch reverseGeoCode:re];
    BOOL flag =[_geoCodeSearch reverseGeoCode:re];
    if (!flag){
        NSLog(@"search failed!");
    }
}

//根据经纬度返回点击的位置的名称
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    NSLog(@"%@",result.address);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:result.address message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}


-(void)viewWillAppear:(BOOL)animated{
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [_mapView viewWillAppear];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    [self passLocationValue];
//    [_mapView updateLocationData:userLocation];
    [_mapView updateLocationData:userLocation];
    
    _mapView.centerCoordinate = userLocation.location.coordinate;
    [_locService stopUserLocationService];//取消定位
}

- (void)leftBtnDidClick:(UIButton *)leftBtn{
    NSLog(@"MAP leftBtnDidClick");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
