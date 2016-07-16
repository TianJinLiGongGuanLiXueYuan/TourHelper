//
//  DetailViewController.h
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/14.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BaseViewController.h"
#import "Detail.h"
#import "DetailUIView.h"
#import "SDCycleScrollView.h"

@interface DetailViewController : BaseViewController<SDCycleScrollViewDelegate>


@property (nonatomic,strong) NSString* titleText;
@property(nonatomic,strong) NSString* detailImg;
@property(nonatomic,strong) NSString* detailText;

@end
