//
//  BaseViewController.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       
    
    [self.view addSubview:self.navigationBar];
    
}


- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        NSLog(@"%ld",(long)status);
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"AFNetworkStatus:未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"AFNetworkStatus:无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"AFNetworkStatus:蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"AFNetworkStatus:WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)leftBtnDidClick:(UIButton *)leftBtn{
//    NSLog(@"leftBtnDidClick");
}
- (void)rightBtnDidClick:(UIButton *)rightBtn{
//    NSLog(@"rightBtnDidClick");
}
- (CustomNavigationBar *)navigationBar{
    if (_navigationBar==Nil) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        _navigationBar = [[CustomNavigationBar alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 64)];
        _navigationBar.delegate = self;
    }
    return _navigationBar;
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
