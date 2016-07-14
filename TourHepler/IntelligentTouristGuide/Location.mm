//
//  Location.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "Location.h"

@implementation Location

- (instancetype)initWithlocationName:(NSString *)locationName voice:(NSString *) voice locationImageName: (NSString *)locationImageName distance:(NSString *)distance locationText:(NSString*)locationText{
    self = [super init];
    if (self) {
        self.locationName = locationName;
        self.voice = voice;
        self.locationImageName = locationImageName;
        self.distance = distance;
        self.locationText = locationText;
    }
    return self;
}

@end
