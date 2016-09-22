//
//  APIClient.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient


+(instancetype)sharedClient{
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //服务器IP
        _sharedClient = [[APIClient alloc]initWithBaseURL:
                         [NSURL URLWithString:@"https://www.zhendehenhaoji.cn"]];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [_sharedClient.requestSerializer setValue:@"2" forHTTPHeaderField:@"Accept"];
    });
    return _sharedClient;
    
}


@end
