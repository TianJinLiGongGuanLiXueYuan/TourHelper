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
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, 414, screenHeight-64)];
    //[mapView setMapType:BMKMapTypeSatellite];
    [self.view addSubview:mapView];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(5, 64+10, screenWidth-10, 40)];
//    searchBar.prompt = @"搜索";
    [self.view addSubview:searchBar];
    
//    //初始化检索对象
//    _searcher =[[BMKPoiSearch alloc]init];
//    _searcher.delegate = self;
//    //发起检索
//    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
//    option.pageIndex = curPage;
//    option.pageCapacity = 10;
//    option.location = CLLocationCoordinate2D{39.915, 116.404};
//    option.keyword = @"小吃";
//    BOOL flag = [_searcher poiSearchNearBy:option];
//    [option release];
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
