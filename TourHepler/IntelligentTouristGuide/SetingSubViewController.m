//
//  SetingSubViewController.m
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/25.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "SetingSubViewController.h"
#import "HttpTool.h"
#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)
#define kViewLeftAndRightMargins 5
#define kViewHeight (1.0/3.0*screenHeight)
#define kViewAndInput 8
#define kBtnWeight (1.0/3.0*screenWidth)
#define kBtnHeight (30)
#define kTVTopMargins (200.0/1920.0*screenHeight)
#define kTVLeftMargins (120.0/1080.0*screenWidth)
#define kTVWidth (831.0/1080.0*screenWidth)
#define kTVheight (861.0/1920.0*screenHeight)
#define kLineMargins (40.0/1080.0*screenWidth)

@interface SetingSubViewController ()

@end

@implementation SetingSubViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationBar.titleLabel.text = @"提出意见";
    [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"旅游助手－返回.png"] forState:UIControlStateNormal];
    [self.navigationBar.rightBtn setHidden:YES];
    
    UIColor *Color = [UIColor colorWithRed:35.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1];
    self.view.backgroundColor = Color;
    
    _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight-64)];
    [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];

    _inputTV.delegate =self;
    _inputTV = [[UITextView alloc]init];
    _inputTV.frame = CGRectMake(kTVLeftMargins, kTVTopMargins, kTVWidth, kTVheight);
//    _inputTV.frame = CGRectMake(kViewLeftAndRightMargins,64+kViewLeftAndRightMargins, screenWidth-kViewLeftAndRightMargins*2, kViewHeight);
    _inputTV.backgroundColor = [UIColor whiteColor];
    _inputTV.layer.masksToBounds = YES;
    _inputTV.layer.cornerRadius = 6.0;
    _inputTV.layer.borderWidth = 1.0;
    
    _inputTV.returnKeyType = UIReturnKeyNext;
    
    _subBtn = [[UIButton alloc]init];
    _subBtn.frame = CGRectMake(kBtnWeight, kTVTopMargins+kTVheight+kViewAndInput, kBtnWeight, kBtnHeight);
    _subBtn.backgroundColor = [UIColor grayColor];
    [_subBtn setTitle:@"提交" forState:UIControlStateNormal];
    _subBtn.titleLabel.textColor = [UIColor whiteColor];
    
    _subBtn.layer.masksToBounds = YES;
    _subBtn.layer.cornerRadius = 6.0;
    _subBtn.layer.borderWidth = 1.0;
    
    [_subBtn addTarget:self action:@selector(subBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_inputTV];
    [self.view addSubview:_subBtn];
    
}


-(void)cancelBtnClick:(UIButton*)sender{
    [_inputTV resignFirstResponder];
}

#pragma  mark- 通过委托放弃第一响应者

-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (void)subBtnClick:(UIButton*)sender{
    //    self.inputTF.showsScopeBar = NO;
    //    [self.searchBar sizeToFit];
    [self.inputTV resignFirstResponder];
    if (![self.inputTV.text isEqualToString:@""]) {
        NSDictionary *para = @{@"opinion_content":self.inputTV.text};
        [HttpTool postWithparamsWithURL:@"subinfo/SubInfoForWeb" andParam:para success:^(id responseObject) {
//            NSData *data = [[NSData alloc]initWithData:responseObject];
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"提示"
                                      message:@"提交成功，谢谢您！"
                                      delegate:nil
                                      cancelButtonTitle:@"关闭"
                                      otherButtonTitles:nil
                                      ];
            //
            [alertView show];
            NSLog(@"成功调用");
            
        } failure:^(NSError *error) {
            NSLog(@"发送失败");
            
        }];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"输入不能为空"
                                  delegate:nil
                                  cancelButtonTitle:@"关闭"
                                  otherButtonTitles:nil
                                  ];
        //
        [alertView show];
    }
}



- (void)leftBtnDidClick:(UIButton *)leftBtn{
    //    NSLog(@"leftBtnDidClick");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
