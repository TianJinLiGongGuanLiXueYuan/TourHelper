//
//  DataSingleton.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/16.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "DataSingleton.h"

@implementation DataSingleton

static DataSingleton* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

-(id)copyWithZone:(struct _NSZone *)zone{
    return _instance;
}

@end