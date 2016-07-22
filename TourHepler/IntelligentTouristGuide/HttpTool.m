//
//  HttpTool.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "APIClient.h"

@implementation HttpTool



+ (void)postWithparamsWithURL:(NSString *)url andParam:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    
    NSString *needURL=[NSString stringWithFormat:@"/TourHelperServer/index.php/Home/%@",url];
    
    [[APIClient sharedClient]POST:needURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}



@end
