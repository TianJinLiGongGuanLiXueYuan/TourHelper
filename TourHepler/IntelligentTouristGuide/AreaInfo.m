//
//  AreaInfo.m
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/8/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "AreaInfo.h"

@implementation AreaInfo

- (instancetype)initWithAreaName:(NSString *)areaTitle img:(NSString *) img{
    self = [super init];
    if (self) {
        self.areaTitle = areaTitle;
        self.areaImg = img;
    }
    return self;
}

@end
