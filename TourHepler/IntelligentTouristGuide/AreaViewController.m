//
//  AreaViewController.m
//  IntelligentTouristGuide
//
//  Created by MuChen on 16/8/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "AreaViewController.h"
#import "Location.h"
#import "LocationInfoCell.h"
#import "MapViewController.h"
#import "DetailViewController.h"
#import "SetingViewController.h"
#import "DataSingleton.h"
#import "HttpTool.h"
#import "SDRefresh.h"
#import "UIImageView+WebCache.h"
#import "NotNetView.h"
#import "AreaInfo.h"
#import "AreaTableViewCell.h"

@interface AreaViewController ()

@property (nonatomic) NSInteger isPlaying;
@property (nonatomic ,strong) UITableViewController *mainTVC;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic) NSInteger CNT;
@property (nonatomic) NSInteger SUM;
@property (nonatomic) NSInteger curSum;



@end

@implementation AreaViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _CNT = 0;
        _curSum = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"旅游助手－首页导航栏左地图icon.png"] forState:UIControlStateNormal];
    [self.navigationBar.rightBtn setImage:[UIImage imageNamed:@"旅游助手－首页设置.png"] forState:UIControlStateNormal];
    [self.navigationBar.titleBtn setTitle:@"热门景区" forState:UIControlStateNormal];
    
    
    _mainTVC = [[UITableViewController alloc]init];
    CGRect tableViewFrame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64);
    self.mainTVC.tableView = [[UITableView alloc]initWithFrame:tableViewFrame style:UITableViewStylePlain];
    //    UIColor *mainTVColor = [UIColor colorWithRed:35.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1];
    self.mainTVC.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTVC.tableView.backgroundColor = [UIColor colorWithRed:0.865 green:1.000 blue:0.991 alpha:1.000];
    self.mainTVC.tableView.allowsSelection = NO;
    self.mainTVC.tableView.delegate = self;
    self.mainTVC.tableView.dataSource = self;
    [self.view addSubview:self.mainTVC.tableView];
    [self getAreaName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 网络接口


- (void) getAreaName{
    
    [HttpTool postWithparamsWithURL:@"homeInfo/GetAllScenicArea" andParam:nil success:^(id responseObject) {
        NSData *data = [[NSData alloc]initWithData:responseObject];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //        NSMutableString *title = [[NSMutableString alloc]initWithString:[[dict objectForKey:@"data"] objectForKey:@"scenic_area_name"]];
        //[@"data"][@"scenic_area_name"]];
        //        NSString *title = [[NSString alloc]initWithString:dict[@"data"][0][@"scenic_area_name"]];
        //        NSLog(@"%@",title);
        if ([dict[@"data"]isEqual:@""]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"提示"
                                      message:@"附近没有景区"
                                      delegate:nil
                                      cancelButtonTitle:@"好的"
                                      otherButtonTitles:nil
                                      ];
            //
            [alertView show];
            
        }else{
            NSMutableArray *teamArr= [[NSMutableArray alloc]initWithArray:[dict objectForKey:@"data"]];
            _dataArr = [[NSMutableArray alloc]init];
            for (NSDictionary *obj in teamArr) {
                [_dataArr addObject:obj[@"scenic_area_name"]];
            }
            if (teamArr.count%3) {
                _CNT = teamArr.count/3;
            }else{
                _CNT = teamArr.count/3 + 1;
            }
            _SUM = teamArr.count;
            [_mainTVC.tableView reloadData];
//            DataSingleton *dataSL = [DataSingleton shareInstance];
//            dataSL.title = [[NSString alloc]initWithString:dict[@"data"][0][@"scenic_area_name"]];
//            [self.navigationBar.titleBtn setTitle:dict[@"data"][0][@"scenic_area_name"] forState:UIControlStateNormal];
//            [self loadDataFromWeb];
        }
        
        //= dict[@"data"][0][@"scenic_spot_name"];
        //        NSLog(@"%@",self.navigationBar.titleLabel.text);
        
        //        NSLog(@"成功调用,%@",dict[@"data"][0]);
        //        return dict[@"data"][0][@"scenic_area_name"];
    } failure:^(NSError *error) {
        NSLog(@"getAreaName：网络数据接受错误");
        
    }];
    
}




#pragma mark - 导航栏相关设置

- (void)titleBtnClick:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)leftBtnDidClick:(UIButton *)leftBtn{
    MapViewController *mapViewController;
    mapViewController = [MapViewController shareInstance];
    mapViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    mapViewController.titleText = self.navigationBar.titleBtn.titleLabel.text;
    //    [UIColor whiteColor]
    
    [self presentViewController:mapViewController animated:YES completion:nil];
}

- (void)rightBtnDidClick:(UIButton *)rightBtn{
    SetingViewController *setingVC = [SetingViewController shareInstance];
    setingVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self.navigationController pushViewController:setingVC animated:YES];
}


#pragma mark - tableView协议
//控制行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _CNT;
    //    return self.dataArr.count;
}
//控制每一行样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    AreaTableViewCell *cell = [[AreaTableViewCell alloc]init];
    if (_CNT==0) {
        return cell;
    }
    //    static NSString *cellIdentifier = @"LocationInfoCell";
    
    //    LocationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //    if (indexPath.row==0) {
    //        if (cell==nil) {
    //            cell = [[NSBundle mainBundle]loadNibNamed:@"LocationInfoCell" owner:nil options:nil].lastObject;
    //        }
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        return cell;
    //    }
    //    NSLog(@"path");
    //    DataSingleton *dataSL = [DataSingleton shareInstance];
    //    dataSL.allVoiceIsPlaying = [[NSMutableArray alloc]initWithArray:dataSL.allVoiceIsPlaying];
    
    //    NSLog(@"%ld",(long)indexPath.row);
//    cell.voiceBtn.tag = indexPath.row;
//    cell.delegate = self;
    //    NSNumber *ok = [[NSNumber alloc]initWithBool:NO];
    //    [dataSL.allVoiceIsPlaying addObject:ok];
    if (cell == nil) {
//        cell = [[NSBundle mainBundle]loadNibNamed:@"LocationInfoCell" owner:nil options:nil].lastObject;
//        cell.voiceBtn.tag = indexPath.row;
//        [cell setImageViewClickBlock:^(UIButton *btn,NSString *locationName,NSString* img,NSString* locationText) {
//            DetailViewController *deVC = [[DetailViewController alloc]init];
//            deVC.titleText = locationName;
//            deVC.detailImg = img;
//            deVC.detailText = locationText;
//            
//            
//            [self.navigationController pushViewController:deVC animated:YES];
//        }];
        
        //        cell = [[NSBundle mainBundle] loadNibNamed:@"LocationInfoCell" owner:nil options:nil].lastObject;
        
    }
    if(indexPath.row==_CNT-1){
        int tem = _SUM%3;
        int row = indexPath.row*3;
        if (tem==1) {
            NSArray *arr = @[_dataArr[row]];
            [cell setCellData:arr sum:1];
        }
        
        if (tem==2) {
            NSArray *arr = @[_dataArr[row],_dataArr[row+1]];
            [cell setCellData:arr sum:2];
        }
        
        if (tem==3) {
            NSArray *arr = @[_dataArr[row],_dataArr[row+1],_dataArr[row+2]];
            [cell setCellData:arr sum:2];
        }
        
        
    }else{
        int row = indexPath.row*3;
        NSArray *arr = @[_dataArr[row],_dataArr[row+1],_dataArr[row+2]];
    
        [cell setCellData:arr sum:3];
    }
//    if (_CNT) {
//        <#statements#>
//    }
//    
//    int tem = (_SUM-_curSum)%3;
//    if (tem) {
//        for (int i = 0; i<tem; i++) {
//            
//        }
//        
//    }else{
//        
//    }
//    
//    
//    
//    AreaInfo *currentArea = self.dataArr[indexPath.row];
//    //        CellFrameInfo *currentFrameInfo = [[CellFrameInfo alloc]initWithStudent:currentStudent];
//    [cell setCellData:currentLocation curPlaying:_isPlaying];
    //    NSLog(@"indexPath.row = %ld",(long)indexPath.row);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    if (_isPlaying==indexPath.row) {
    //        [cell.voiceBtn setBackgroundImage:[UIImage imageNamed:@"54C5D57F9705BCC1D0486DB7D059E2E3.png"] forState:UIControlStateNormal];
    //    }
    
    return cell;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSLog(@"%@",indexPath);
    //    NSLog(@"%ld",(long)indexPath.row);
    //    if (indexPath.row==0) {
    //        return 64;
    //    }
    return [AreaTableViewCell returnCellHeight];
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //    DetailViewController *detailViewController = [[DetailViewController alloc]init];
    ////    detailViewController.titleText = locationName;
    ////    detailViewController.detailImg = img;
    ////    detailViewController.detailText = locationText;
    //    [self.navigationController pushViewController:detailViewController animated:YES ];
    //    
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
