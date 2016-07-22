//
//  DataSingleton.h
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/16.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
//#import "Location.h"

@interface DataSingleton : NSObject

@property(nonatomic,strong) NSMutableArray* allDetail;
@property(nonatomic,strong) NSMutableArray* allImgWithLocation;

//@property(nonatomic,strong) NSArray* allDetailText;

+(instancetype) shareInstance; 



@end
