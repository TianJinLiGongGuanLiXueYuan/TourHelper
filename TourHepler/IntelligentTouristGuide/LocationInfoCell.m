//
//  LocationInfoCell.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "LocationInfoCell.h"
#import "DetailViewController.h"

@interface LocationInfoCell ()

@property (strong, nonatomic) Location *currentLocation;
@property (strong, nonatomic) DetailViewController *detailViewController;

@end

@implementation LocationInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)imageBtnClick:(id)sender {
//    _detailViewController = [[DetailViewController alloc]init];
////    _detailViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    _detailViewController.titleText = self.locationNameLabel.text;
    
    self.imageViewClickBlock((UIButton *)sender,[NSString stringWithString:_locationNameLabel.text]);
    
}

- (void)setCellData:(Location*)location{
    self.currentLocation = location;
    [self.locationImage setImage:[UIImage imageNamed:location.locationImageName]];
    
    
    self.locationNameLabel.text = self.currentLocation.locationName;
    self.distanceLabel.text = self.currentLocation.distance;
}

@end
