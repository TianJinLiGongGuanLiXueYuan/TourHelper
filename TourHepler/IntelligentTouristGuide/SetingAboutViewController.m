//
//  SetingAboutViewController.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/14.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "SetingAboutViewController.h"

@interface SetingAboutViewController ()

@end

@implementation SetingAboutViewController

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
    [self.navigationBar.titleBtn setTitle:@"提出意见" forState:UIControlStateNormal];
//    self.navigationBar.titleBtn.titleLabel.text = @"提出意见";
    [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"旅游助手－返回.png"] forState:UIControlStateNormal];
    [self.navigationBar.rightBtn setHidden:YES];
    
    UITextView *about = [[UITextView alloc]initWithFrame:CGRectMake(5,15+64, 414-10, 3000)];
    about.text = @"出门看看美好的世界";
    [about setEditable:NO];
    about.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:about];
    
}

-(void) titleBtnClick:(UIButton *)btn{
    
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
