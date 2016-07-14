//
//  HomeViewController.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/13.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "HomeViewController.h"
#import "Location.h"
#import "LocationInfoCell.h"
#import "MapViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) NSArray *dataArr;
@end

@interface HomeViewController ()

@property (nonatomic ,strong) UITableView *mainTableView;
@property (nonatomic ,strong) MapViewController *mapViewController;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDataFromWeb];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationBar.titleLabel.text = @"九寨沟";
    [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"homeNabigationLeftIcon.ico"] forState:UIControlStateNormal];
    [self.navigationBar.rightBtn setImage:[UIImage imageNamed:@"homeNabigationRightIcon.ico"] forState:UIControlStateNormal];
    
    CGRect tableViewFrame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64);
    
    self.mainTableView = [[UITableView alloc]initWithFrame:tableViewFrame style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.mainTableView];
}

- (void) loadDataFromWeb{
    Location *Location1 = [[Location alloc]initWithlocationName:@"卧龙海" voice:@""locationImageName:@"卧龙海.jpeg" distance:@"1.2KM"];
    Location *Location2 = [[Location alloc]initWithlocationName:@"箭竹海" voice:@""locationImageName:@"箭竹海.jpg" distance:@"1.3KM"];
    Location *Location3 = [[Location alloc]initWithlocationName:@"芦苇海" voice:@""locationImageName:@"芦苇海.jpg" distance:@"1.4KM"];
    Location *Location4 = [[Location alloc]initWithlocationName:@"双龙海" voice:@""locationImageName:@"双龙海.jpg" distance:@"1.5KM"];
    self.dataArr = @[Location1,Location2,Location3,Location4];
}

//控制行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataArr.count;
}
//控制每一行样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    NSLog(@"path");
    static NSString *cellIdentifier = @"LocationInfoCell";
    LocationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"LocationInfoCell" owner:nil options:nil].lastObject;
        
//        cell = [[NSBundle mainBundle] loadNibNamed:@"LocationInfoCell" owner:nil options:nil].lastObject;
        Location *currentLocation =self.dataArr[indexPath.row];
//        CellFrameInfo *currentFrameInfo = [[CellFrameInfo alloc]initWithStudent:currentStudent];
        [cell setCellData:currentLocation];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 189;
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)leftBtnDidClick:(UIButton *)leftBtn{
    NSLog(@"HOME leftBtnDidClick");
//    if (self.mapViewController == nil) {
//        
//        /*
//         86          最常用的初始化方法
//         87          nibName 表示xib文件的名字,不包括扩展名
//         88          nibBundle 制定在那个文件束中搜索制定的nib文件,如在主目录下,则可以直接用nil
//         89          */
//        
//    }
//    //视图切换的动画效果
//    self.thirdViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    void(^task)() = ^{
//        NSLog(@"2self: %@",self);
//        NSLog(@"2go ed%@",self.presentedViewController);
//        NSLog(@"2go ing%@",self.presentingViewController);
//        //  NSLog(@"go par%@",self.parentViewController);
//        printf("\n\n");
//    };
//    // task = ^(){};
//    // task();//跳转前没意义
//    /*
//     111      completion是一个回调,当 当前视图(这里是TWFXViewController) 的viewDidDisear调用后,该回调被调用
//     112      self.presentingViewController(表示上一个视图)为A视图
//     113      self.presentedViewController(表示下一个试图)为C视图
//     114      */
    _mapViewController = [[MapViewController alloc]init];
    _mapViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    _mapViewController.titleText = self.navigationBar.titleLabel.text;
    [self presentViewController:_mapViewController animated:YES completion:nil];

}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
