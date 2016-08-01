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
#define kBtenHeight (30)
#define kInputTFWeight (15.0/16.0*screenWidth)
#define kInputTFHeight (40)
#define kBtnCnt (3)

@implementation MySearchBar

- (instancetype)init
{
    self = [super init];
    if (self) {

        self.frame = CGRectMake(0, 64+kViewLeftAndRightMargins, screenWidth, kInputTFHeight+kBtenHeight+kViewLeftAndRightMargins);
        self.backgroundColor = [UIColor clearColor];
        
//        [self addSubview:self.inputTF];
        
        [self addSubview:self.locationBtn];
        
        [self addSubview:self.wcBtn];
        
        [self addSubview:self.foodBtn];
        
    }
    return self;
}

#pragma mark - 初始化

//- (UITextField *)inputTF{
//    if (_inputTF==Nil) {
//        _inputTF = [[UITextField alloc]init];
//        _inputTF.frame = CGRectMake((screenWidth-kInputTFWeight)/2.0, 0, kInputTFWeight, kInputTFHeight);
//        _inputTF.backgroundColor = [UIColor whiteColor];
//        _inputTF.layer.masksToBounds = YES;
//        _inputTF.layer.cornerRadius = 6.0;
//        _inputTF.layer.borderWidth = 0;
//        _inputTF.placeholder = @"点击搜索";
//        _inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        UIImageView *inputView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kInputTFHeight-17, kInputTFHeight-17)];
//        [inputView setImage:[UIImage imageNamed:@"旅游助手－搜索.png"]];
//        _inputTF.leftView=inputView;
//        _inputTF.leftViewMode = UITextFieldViewModeAlways;
////        //        _locationBtn.titleLabel.textColor = [UIColor blackColor];
////        [_locationBtn setTitle:@"景点" forState:UIControlStateNormal];
////        [_locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
////        
////        [_locationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _inputTF;
//}

- (UIButton *)locationBtn{
    if (_locationBtn==Nil) {
        _locationBtn = [[UIButton alloc]init];
        _locationBtn.frame = CGRectMake((screenWidth - (kBtnWeight*kBtnCnt+kViewLeftAndRightMargins*(kBtnCnt-1)))/2.0, kInputTFHeight+kViewLeftAndRightMargins, kBtnWeight, kBtenHeight);
        _locationBtn.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:162.0/255.0 blue:145.0/255.0 alpha:1];
        _locationBtn.layer.masksToBounds = YES;
//        _locationBtn.layer.cornerRadius = 6.0;
        _locationBtn.layer.borderWidth = 1;
        _locationBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//        [_locationBtn.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
//        _locationBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
        [_locationBtn.layer setCornerRadius:30.0/3.1415926];
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
        _wcBtn.frame = CGRectMake(kViewLeftAndRightMargins+kBtnWeight+(screenWidth - (kBtnWeight*kBtnCnt+kViewLeftAndRightMargins*(kBtnCnt-1)))/2.0, kInputTFHeight+kViewLeftAndRightMargins, kBtnWeight, kBtenHeight);
        _wcBtn.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:162.0/255.0 blue:145.0/255.0 alpha:1];
        _wcBtn.layer.masksToBounds = YES;
//        _wcBtn.layer.cornerRadius = 6.0;
        _wcBtn.layer.borderWidth = 1;
        _wcBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_wcBtn.layer setCornerRadius:30.0/3.1415926];
        [_wcBtn setTitle:@"厕所" forState:UIControlStateNormal];
        [_wcBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_wcBtn addTarget:self action:@selector(wcBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wcBtn;
}

- (UIButton *)foodBtn{
    if (_foodBtn==Nil) {
        _foodBtn = [[UIButton alloc]init];
        _foodBtn.frame = CGRectMake(kViewLeftAndRightMargins*2+kBtnWeight*2+(screenWidth - (kBtnWeight*kBtnCnt+kViewLeftAndRightMargins*(kBtnCnt-1)))/2.0, kInputTFHeight+kViewLeftAndRightMargins, kBtnWeight, kBtenHeight);
        _foodBtn.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:162.0/255.0 blue:145.0/255.0 alpha:1];
        _foodBtn.layer.masksToBounds = YES;
//        _foodBtn.layer.cornerRadius = 6.0;
        _foodBtn.layer.borderWidth = 1;
        _foodBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_foodBtn.layer setCornerRadius:30.0/3.1415926];
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

//- (void)returnBtnClick:(UIButton*)btn{
//    [self.delegate returnBtnClick:btn];
//    
//}



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
