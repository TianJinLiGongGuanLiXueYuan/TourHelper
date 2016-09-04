//
//  AreaTableViewCell.m
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/8/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "AreaTableViewCell.h"
#import "AreaInfo.h"
#import "UIImageView+WebCache.h"
#import "HomeViewController.h"
#import "AreaViewController.h"
#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)
#define kBtnWeight (screenWidth*1.0/4.0)
#define kMargins (screenWidth/16.0)
#define kStrHeight (60)
#define kBtnAndName (0)


@implementation AreaTableViewCell



- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleBtn = [[UIButton alloc]init];
        _area1 = [[UIButton alloc]init];
        _area2 = [[UIButton alloc]init];
        _area3 = [[UIButton alloc]init];
        
        _areaName1 = [[UIButton alloc]init];
        _areaName2 = [[UIButton alloc]init];
        _areaName3 = [[UIButton alloc]init];
        
        _area1.frame = CGRectMake(kMargins, kMargins, kBtnWeight, kBtnWeight);
        _areaName1.frame = CGRectMake(kMargins, kMargins+kBtnWeight+kBtnAndName, kBtnWeight, kStrHeight);
        _area1.backgroundColor = [UIColor redColor];
        _area2.frame = CGRectMake(kMargins*2+kBtnWeight, kMargins, kBtnWeight, kBtnWeight);
        _areaName2.frame = CGRectMake(kMargins+kBtnWeight+kMargins, kMargins+kBtnWeight+kBtnAndName, kBtnWeight, kStrHeight);
        _area2.backgroundColor = [UIColor greenColor];
        _area3.frame = CGRectMake(kMargins*3+kBtnWeight*2, kMargins, kBtnWeight, kBtnWeight);
        _areaName3.frame = CGRectMake(kMargins+kBtnWeight+kMargins+kBtnWeight+kMargins, kMargins+kBtnWeight+kBtnAndName, kBtnWeight, kStrHeight);
        _area3.backgroundColor = [UIColor yellowColor];
        
        
        _area1.layer.masksToBounds = YES;
        _area1.layer.cornerRadius = 6.0;
        _area1.layer.borderWidth = 1.0;
        _area2.layer.masksToBounds = YES;
        _area2.layer.cornerRadius = 6.0;
        _area2.layer.borderWidth = 1.0;
        _area3.layer.masksToBounds = YES;
        _area3.layer.cornerRadius = 6.0;
        _area3.layer.borderWidth = 1.0;
        
        
        _areaName1.titleLabel.lineBreakMode = 0;
        _areaName2.titleLabel.lineBreakMode = 0;
        _areaName3.titleLabel.lineBreakMode = 0;
        self.contentView.backgroundColor = [UIColor colorWithRed:35.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1];
//        _area1.layer.borderColor = [cellBackViewColor CGColor];
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat) returnCellHeight{
    return kMargins+kBtnWeight+kBtnAndName+kStrHeight;
}


//- (IBAction)BtnClick:(id)sender {
//    UIButton *btn = [[UIButton alloc]init];
//    btn = sender;
//    self.btnClickBlock((UIButton *)sender,[NSString stringWithString:btn.titleLabel.text]);
//    
////    self.ClickBlock((UIButton *)sender,[NSString stringWithString:_locationNameLabel.text],[NSString stringWithString:_imgName],[NSString stringWithString:_cellText]);
//    
//}

- (void)BtnClick:(UIButton *)btn
{
//    HomeViewController *homeVC = [[HomeViewController alloc]initWithAreaName:btn.titleLabel.text];
//    [self.mainVC presentViewController:homeVC animated:YES completion:nil];
    [self.delegate BtnClick:btn];
}

- (void)setCellData:(NSArray*)area sum:(NSInteger)sum{
    if (area==nil) {
        return;
    }
    
    UIColor *selfViewColor = [UIColor colorWithRed:35.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1];
    self.backgroundColor = selfViewColor;
    
    
    if (sum==1) {
        AreaInfo *area1 = area[0];
        [_areaName1 setTitle:area1.areaTitle forState:UIControlStateNormal];
//        [_areaName1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        NSURL * nurl=[[NSURL alloc] initWithString:[area1.areaImg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        UIImageView *img = [[UIImageView alloc]init];
        [img sd_setImageWithURL:nurl  placeholderImage:[UIImage imageNamed:@"等待.png"]];
        [_area1 setImage:img.image forState:UIControlStateNormal];
        [_area1 setTitle:area1.areaTitle forState:UIControlStateNormal];
        
        [_area1 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_area1];
        
        [self.contentView addSubview:_areaName1];
    }
    
    if(sum==2) {
        AreaInfo *area1 = area[0];
        AreaInfo *area2 = area[1];
        [_areaName1 setTitle:area1.areaTitle forState:UIControlStateNormal];
//        [_areaName1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        NSURL * nurl=[[NSURL alloc] initWithString:[area1.areaImg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        UIImageView *img = [[UIImageView alloc]init];
        [img sd_setImageWithURL:nurl  placeholderImage:[UIImage imageNamed:@"等待.png"]];
        [_area1 setImage:img.image forState:UIControlStateNormal];
        [_area1 setTitle:area1.areaTitle forState:UIControlStateNormal];
//        [_area1.imageView sd_setImageWithURL:nurl  placeholderImage:[UIImage imageNamed:@"等待.png"]];
        
        [_areaName2 setTitle:area1.areaTitle forState:UIControlStateNormal];
//        [_areaName2 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        NSURL * nurl1=[[NSURL alloc] initWithString:[area2.areaImg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        UIImageView *img1 = [[UIImageView alloc]init];
        [img1 sd_setImageWithURL:nurl1  placeholderImage:[UIImage imageNamed:@"等待.png"]];
        [_area2 setImage:img1.image forState:UIControlStateNormal];
        [_area2 setTitle:area2.areaTitle forState:UIControlStateNormal];
//        [_area2.imageView sd_setImageWithURL:nurl1  placeholderImage:[UIImage imageNamed:@"等待.png"]];
        
        [_area1 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_area2 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.contentView addSubview:_area1];
        [self.contentView addSubview:_area2];
        
        [self.contentView addSubview:_areaName1];
        [self.contentView addSubview:_areaName2];
    }
    
    if (sum==3) {
        AreaInfo *area1 = area[0];
        AreaInfo *area2 = area[1];
        AreaInfo *area3 = area[2];
        [_areaName1 setTitle:area1.areaTitle forState:UIControlStateNormal];
//        [_areaName1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        
        NSURL * nurl=[[NSURL alloc] initWithString:[area1.areaImg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        UIImageView *img = [[UIImageView alloc]init];
        [img sd_setImageWithURL:nurl  placeholderImage:[UIImage imageNamed:@"等待.png"]];
        [_area1 setImage:img.image forState:UIControlStateNormal];
        [_area1 setTitle:area1.areaTitle forState:UIControlStateNormal];
        
//        [_area1.imageView sd_setImageWithURL:nurl  placeholderImage:[UIImage imageNamed:@"等待.png"]];
        
        
        [_areaName2 setTitle:area2.areaTitle forState:UIControlStateNormal];
//        [_areaName2 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        NSURL * nurl1=[[NSURL alloc] initWithString:[area2.areaImg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        UIImageView *img1 = [[UIImageView alloc]init];
        [img1 sd_setImageWithURL:nurl1  placeholderImage:[UIImage imageNamed:@"等待.png"]];
        [_area2 setImage:img1.image forState:UIControlStateNormal];
        [_area2 setTitle:area2.areaTitle forState:UIControlStateNormal];
        
//        [_area2.imageView sd_setImageWithURL:nurl1  placeholderImage:[UIImage imageNamed:@"等待.png"]];
        
        
        [_areaName3 setTitle:area3.areaTitle forState:UIControlStateNormal];
//        [_areaName3 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        
        NSURL * nurl2=[[NSURL alloc] initWithString:[area3.areaImg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        UIImageView *img2 = [[UIImageView alloc]init];
        [img2 sd_setImageWithURL:nurl2  placeholderImage:[UIImage imageNamed:@"等待.png"]];
        [_area3 setImage:img2.image forState:UIControlStateNormal];
        [_area3 setTitle:area3.areaTitle forState:UIControlStateNormal];
        
//        [_area3.imageView sd_setImageWithURL:nurl2  placeholderImage:[UIImage imageNamed:@"等待.png"]];
        
        [_area1 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_area2 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_area3 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [self.contentView addSubview:_area1];
        [self.contentView addSubview:_area2];
        [self.contentView addSubview:_area3];
        
        [self.contentView addSubview:_areaName1];
        [self.contentView addSubview:_areaName2];
        [self.contentView addSubview:_areaName3];
    }
    
    
    
    
    
    
}

@end
