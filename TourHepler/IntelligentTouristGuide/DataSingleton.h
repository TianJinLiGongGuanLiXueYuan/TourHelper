//
//  DataSingleton.h
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/16.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
//#import "Location.h"

@interface DataSingleton : NSObject

@property(nonatomic,strong) NSMutableArray* allDetail;
@property(nonatomic,strong) NSMutableArray* allImgWithLocation;
@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSDictionary* dataDict;
@property(nonatomic,strong) NSMutableArray* allVoiceIsPlaying;
@property(nonatomic,strong) BMKMapView* mapView;
@property(nonatomic) BMKMapPoint userPoint;
//bool allVoiceIsPlaying[100];

//@property(nonatomic,strong) NSArray* allDetailText;

+(instancetype) shareInstance; 



@end
