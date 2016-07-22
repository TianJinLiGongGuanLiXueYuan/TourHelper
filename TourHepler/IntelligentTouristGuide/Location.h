//
//  Location.h
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject

@property (nonatomic ,strong)NSString *locationName;
@property (nonatomic ,strong)NSString *voice;
@property (nonatomic ,strong)NSString *locationImageName;
@property (nonatomic ,strong)NSString *distance;
@property (nonatomic ,strong)NSString *locationText;
@property (nonatomic) CLLocationCoordinate2D coor;

- (instancetype)initWithlocationName:(NSString *)locationName voice:(NSString *) voice locationImageName: (NSString *)locationImageName distance:(NSString *)distance locationText:(NSString*)locationText coor:(CLLocationCoordinate2D)coor;

@end
