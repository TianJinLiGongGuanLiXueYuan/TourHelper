//
//  DetailViewController.m
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/7/14.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()



@end

@implementation DetailViewController

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
    self.navigationBar.titleLabel.text = self.titleText;
    [self.navigationBar.rightBtn setImage:[UIImage imageNamed:@"语音.ico"] forState:UIControlStateNormal];
    UIImageView *locationImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 414, 300)];
    [locationImg setImage:[UIImage imageNamed:self.detailImg]];
    locationImg.backgroundColor = [UIColor redColor];
    [self.view addSubview:locationImg];
    
    UITextView *locationTV = [[UITextView alloc]initWithFrame:CGRectMake(0,300+64, 414, 280)];
    locationTV.text = self.detailText;
    [locationTV setEditable:NO];
    locationTV.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:locationTV];
    
    UIButton *detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 64+300+280+10, 414-40, 40)];
    [detailBtn setTitle:@"我要到这里去" forState:UIControlStateNormal];
    detailBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:detailBtn];
    
    
    [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"homeNabigationLeftIcon.ico"] forState:UIControlStateNormal];
    [self.navigationBar.rightBtn setImage:[UIImage imageNamed:@"homeNabigationRightIcon.ico"] forState:UIControlStateNormal];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBtnDidClick:(UIButton *)leftBtn{
//    NSLog(@"Detail leftBtnClick");
    [self.navigationController popViewControllerAnimated:YES];

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
