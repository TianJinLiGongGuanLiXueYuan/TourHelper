//
//  MySearchBar.m
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/21.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MySearchBar.h"
#import "HttpTool.h"
#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)
#define kViewLeftAndRightMargins (5)
#define kViewHeight (40)
#define kViewAndInput (8)
#define kBtnWeight (2.0/9.0*screenWidth)
#define kBtenHeight (40)

@implementation MySearchBar

- (instancetype)init
{
    self = [super init];
    if (self) {

        self.frame = CGRectMake((screenWidth-(kBtnWeight*3+4*kViewLeftAndRightMargins))/2.0, 64+kViewLeftAndRightMargins, kBtnWeight*3+4*kViewLeftAndRightMargins, kBtenHeight+kViewLeftAndRightMargins*2);
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.locationBtn];
        
        [self addSubview:self.wcBtn];
        
        [self addSubview:self.foodBtn];
        
    }
    return self;
}

#pragma mark - 按钮初始化

- (UIButton *)locationBtn{
    if (_locationBtn==Nil) {
        _locationBtn = [[UIButton alloc]init];
        _locationBtn.frame = CGRectMake(kViewLeftAndRightMargins, kViewLeftAndRightMargins, kBtnWeight, kBtenHeight);
        _locationBtn.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:166.0/255.0 blue:176.0/2555.0 alpha:1];
        _locationBtn.layer.masksToBounds = YES;
        _locationBtn.layer.cornerRadius = 6.0;
        _locationBtn.layer.borderWidth = 0;
        //        _locationBtn.titleLabel.textColor = [UIColor blackColor];
        [_locationBtn setTitle:@"景点" forState:UIControlStateNormal];
        [_locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [_locationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locationBtn;
}

- (UIButton *)wcBtn{
    if (_wcBtn==Nil) {
        _wcBtn = [[UIButton alloc]init];
        _wcBtn.frame = CGRectMake(kViewLeftAndRightMargins*2+kBtnWeight, kViewLeftAndRightMargins, kBtnWeight, kBtenHeight);
        _wcBtn.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:206.0/255.0 blue:176.0/255.0 alpha:1];
        _wcBtn.layer.masksToBounds = YES;
        _wcBtn.layer.cornerRadius = 6.0;
        _wcBtn.layer.borderWidth = 0;
        [_wcBtn setTitle:@"厕所" forState:UIControlStateNormal];
        [_wcBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_wcBtn addTarget:self action:@selector(wcBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wcBtn;
}

- (UIButton *)foodBtn{
    if (_foodBtn==Nil) {
        _foodBtn = [[UIButton alloc]init];
        _foodBtn.frame = CGRectMake(kViewLeftAndRightMargins*3+kBtnWeight*2, kViewLeftAndRightMargins, kBtnWeight, kBtenHeight);
        _foodBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:225.0/255.0 blue:205.0/255.0 alpha:1];
        _foodBtn.layer.masksToBounds = YES;
        _foodBtn.layer.cornerRadius = 6.0;
        _foodBtn.layer.borderWidth = 0;
        [_foodBtn setTitle:@"饭店" forState:UIControlStateNormal];
        [_foodBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_foodBtn addTarget:self action:@selector(foodBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _foodBtn;
}

#pragma mark - 按钮点击事件

- (void)locationBtnClick:(UIButton *)btn
{
    [self.delegate locationBtnClick:btn];
}

- (void)wcBtnClick:(UIButton *)btn
{
    [self.delegate wcBtnClick:btn];
}

- (void)foodBtnClick:(UIButton *)btn
{
    [self.delegate foodBtnClick:btn];
}





//#pragma  mark- 通过委托放弃第一响应者

//-(BOOL) textFieldShouldReturn:(UITextField *)textField{
//    
//    NSDictionary *para = @{@"scenic_spot_name":textField.text};
//    
//    [HttpTool postWithparamsWithURL:@"homeInfo/GetInfoWithSearch" andParam:para success:^(id responseObject) {
//        NSData *data = [[NSData alloc]initWithData:responseObject];
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        
////        NSLog(@"成功调用,%@",dict);
//    } failure:^(NSError *error) {
//        NSLog(@"网络信息错误");
//        
//    }];
//    [textField resignFirstResponder];
//    return YES;
//}

//- (void)returnBtnClick:(UIButton*)sender{
////    self.inputTF.showsScopeBar = NO;
//    //    [self.searchBar sizeToFit];
////    NSLog(@"%@",_inputTF.text);
//    
//    [self.inputTF resignFirstResponder];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
