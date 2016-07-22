//
//  HttpTool.h
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Success)(id responseObject);
typedef void (^Failure)(NSError *error);

@interface HttpTool : NSObject


+ (void)postWithparamsWithURL:(NSString *)url andParam:(NSDictionary *)params success:(Success)success failure:(Failure)failure;
@end
