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
#import "DetailViewController.h"
#import "SetingViewController.h"
#import "DataSingleton.h"
#import "HttpTool.h"
#import "SDRefresh.h"
#import "UIImageView+WebCache.h"



@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,BMKLocationServiceDelegate,LocationInfoCellDelegate>

@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) BMKLocationService* locService;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic) NSInteger cnt;
@property (nonatomic) NSInteger sum;
@property (nonatomic) NSInteger isPlaying;
@property (nonatomic) CGFloat tableViewPosPre;
@property (nonatomic) BOOL isNavigationBarDisplay;
//@property (readonly, nonatomic,strong) CLLocation *homeLocation;

@end

@interface HomeViewController ()

@property (nonatomic ,strong) UITableViewController *mainTVC;
//@property (nonatomic,strong) NSMutableArray *mainDict;
//@property (nonatomic ,strong) MapViewController *mapViewController;
//@property (nonatomic ,strong) DetailViewController *deVC;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cnt = 3;
    _sum = 0;
    _isPlaying = -1;
    _isNavigationBarDisplay = 1;
    _tableViewPosPre = 64;
    // Do any additional setup after loading the view.
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
//    [self getAreaName];
    
#pragma mark - 导航栏初始化
    
//    NSLog(@"%@",self.mainDict);
    [self.navigationController setNavigationBarHidden:YES];
//    self.navigationBar.titleLabel.text = @"九寨沟";
    [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"旅游助手－首页导航栏左地图icon.png"] forState:UIControlStateNormal];
    [self.navigationBar.rightBtn setImage:[UIImage imageNamed:@"旅游助手－首页设置.png"] forState:UIControlStateNormal];
    
    
    //测试网络接口
//    [self testWebServer];
//    [self getSpotInfoWordForWeb];
//    [self GetSpotImgInfoWithSpotName];
    
    
//    self.mainTableView.bo
    _mainTVC = [[UITableViewController alloc]init];
    CGRect tableViewFrame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64);
    self.mainTVC.tableView = [[UITableView alloc]initWithFrame:tableViewFrame style:UITableViewStylePlain];
//    UIColor *mainTVColor = [UIColor colorWithRed:35.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1];
    self.mainTVC.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTVC.tableView.backgroundColor = [UIColor colorWithRed:0.865 green:1.000 blue:0.991 alpha:1.000];
    self.mainTVC.tableView.allowsSelection = NO;
    self.mainTVC.tableView.delegate = self;
    self.mainTVC.tableView.dataSource = self;
    self.mainTVC.tableView.tableFooterView = [[UIView alloc]init];
    
    [self setupHeader];
    [self setupFooter];
    
    if([self.mainTVC.tableView respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.mainTVC.automaticallyAdjustsScrollViewInsets = NO;
        UIEdgeInsets insets = self.mainTVC.tableView.contentInset;
        insets.top =self.navigationBar.bounds.size.height;
        self.mainTVC.tableView.contentInset =insets;
        self.mainTVC.tableView.scrollIndicatorInsets = insets;
    }
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainTVC.tableView];
    [self.view addSubview:self.navigationBar];
    //或者 refreshHeader.beginRefreshingOperation = ^{} 任选其中一种即可
    
//    [self addChildViewController:_mainTVC];
    

    
}
#pragma mark - 语音合成
- (void)onCompleted:(IFlySpeechError *)error{
    [_iFlySpeechSynthesizer stopSpeaking];
    NSIndexPath *index = [NSIndexPath indexPathForRow:_isPlaying inSection:0];
    LocationInfoCell *preCell = [_mainTVC.tableView cellForRowAtIndexPath:index];
    [preCell.voiceBtn setBackgroundImage:[UIImage imageNamed:@"旅游助手－播放语音.png"] forState:UIControlStateNormal];
    _isPlaying = -1;
}



#pragma mark - 刷新控件

- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    //
    //    //加入到目标tableview，默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:self.mainTVC.tableView];
    refreshHeader.isEffectedByNavigationController = NO;
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    __weak typeof(self) weakSelf = self;
    refreshHeader.beginRefreshingOperation = ^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//        });
        if (weakSelf.cnt+3<=weakSelf.sum) {
            weakSelf.cnt += 3;
        }else
            weakSelf.cnt = weakSelf.sum;
        [_iFlySpeechSynthesizer stopSpeaking];
        [self.mainTVC.tableView reloadData];
        [weakRefreshHeader endRefreshing];
    };
    // 进入页面自动加载一次数据
    [refreshHeader autoRefreshWhenViewDidAppear];
}

- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    [refreshFooter addToScrollView:self.mainTVC.tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}

- (void)footerRefresh
{
    if (_cnt!=_sum){
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (_cnt+3<=_sum) {
//                _cnt += 3;
//            }else
//                _cnt = _sum;
//            [self.mainTVC.tableView reloadData];
//            [self.refreshFooter endRefreshing];
//        });
        if (_cnt+3<=_sum) {
            _cnt += 3;
        }else
            _cnt = _sum;
        [_iFlySpeechSynthesizer stopSpeaking];
        [self.mainTVC.tableView reloadData];
        [self.refreshFooter endRefreshing];
    }else{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//        });
        [self.refreshFooter setSDRefreshViewRefreshingStateText:@"已到最低"];
        [self.refreshFooter setSDRefreshViewWillRefreshStateText:@"已到最底"];
        [self.refreshFooter endRefreshing];
    }
}
#pragma mark - 地图坐标更新
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    _homeCenterCC2D.latitude = userLocation.location.coordinate.latitude;
//    _homeCenterCC2D.longitude = userLocation.location.coordinate.longitude;
//    _homeLocation = userLocation.location;
    [self getAreaName];
    
    [_locService stopUserLocationService];//取消定位
}

- (void) reLoadImgDetail:(NSDictionary*)dict{
    DataSingleton* dataSL = [DataSingleton shareInstance];
    dataSL.allImgWithLocation = [[NSMutableArray alloc]initWithArray:dataSL.allImgWithLocation];
    if ([dict[@"data"]isEqual:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"附近没有景区"
                                  delegate:nil
                                  cancelButtonTitle:@"好的"
                                  otherButtonTitles:nil
                                  ];
        [alertView show];
    }else{
        NSMutableArray *teamArr= [[NSMutableArray alloc]initWithArray:[dict objectForKey:@"data"]];
        NSMutableArray *Img = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in teamArr) {
            
            [Img addObject:[[NSURL alloc] initWithString:[obj[@"scenic_spot_picture"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        }
        [dataSL.allImgWithLocation addObject:Img];
    }
}

- (void) reLoad:(NSDictionary*)dict{
    NSMutableArray *teamArr= [[NSMutableArray alloc]initWithArray:[dict objectForKey:@"data"]];
    _sum = teamArr.count;
    _dataArr = [[NSMutableArray alloc]init];
    DataSingleton* dataSL = [DataSingleton shareInstance];
    dataSL.allDetail = [[NSMutableArray alloc]initWithArray:dataSL.allDetail];
    for (NSDictionary *obj in teamArr) {
        NSString *latitude = [NSString stringWithFormat:@"%@",[obj objectForKey:@"scenic_spot_latitude"]];
        NSString *longitude = [NSString stringWithFormat:@"%@",[obj objectForKey:@"scenic_spot_longitude"]];
        double latitudeDou = [latitude floatValue];
        double longitudeDou = [longitude floatValue];
        
//        NSLog(@"%f %f",_locService.userLocation.location.coordinate.latitude,_locService.userLocation.location.coordinate.longitude);
//        NSLog(@"%f %f",latitudeDou,longitudeDou);
        BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(_locService.userLocation.location.coordinate.latitude,_locService.userLocation.location.coordinate.longitude));
        BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(latitudeDou,longitudeDou));
        CGFloat distance = BMKMetersBetweenMapPoints(point1,point2);
        NSString *distanceString;
        if (distance>1000.0) {
            distance/=1000.0;
            distanceString = [NSString stringWithFormat:@"%.4g",distance];
            distanceString = [distanceString stringByAppendingString:@"km"];
        }else{
            distanceString = [NSString stringWithFormat:@"%g",distance];
            distanceString = [distanceString stringByAppendingString:@"m"];
        }
        
        
//        NSLog(@"%@",obj);
        Location *location = [[Location alloc]initWithlocationName:[obj objectForKey:@"scenic_spot_name"] voice:[obj objectForKey:@"scenic_spot_voice"] locationImageName:[obj objectForKey:@"scenic_spot_picture"] distance:distanceString locationText:[obj objectForKey:@"scenic_spot_introduction"] coor:(CLLocationCoordinate2D){latitudeDou,longitudeDou}];
        
        [_dataArr addObject:location];
        [dataSL.allDetail addObject:location];
        
        NSDictionary *para = @{@"scenic_spot_name":location.locationName};
        [HttpTool postWithparamsWithURL:@"homeInfo/GetSpotImgInfoWithSpotName" andParam:para success:^(id responseObject) {
            NSData *data = [[NSData alloc]initWithData:responseObject];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [self reLoadImgDetail:dict];
            NSLog(@"成功调用,%@",dict);
            
        } failure:^(NSError *error) {
            NSLog(@"景点没有图片");
            
        }];
        
        
        
    }
    
    
//    self.mainTableView.delegate = self;
//    self.mainTableView.dataSource = self;
//    [self setupHeader];
    [_mainTVC.tableView reloadData];
//    NSLog(@"%@",self.dataArr);
    
    
}

- (void) loadDataFromWeb{
//    Location *Location1 = [[Location alloc]initWithlocationName:@"卧龙海" voice:@"" locationImageName:@"卧龙海.jpeg" distance:@"1.2KM" locationText:@"卧龙海海拔2215米，深22米。小巧玲珑的卧龙海是蓝色湖泊典型的代表，极浓重的蓝色醉人心田。湖面水波不兴，宁静祥和，像一块光滑平整、晶莹剔透的蓝宝石。透过波平如镜的水面，一条乳白色钙华长堤横卧湖心，宛若一条蛟龙潜游海底。"coor:(CLLocationCoordinate2D){103.907089,33.206952}];
//    Location *Location2 = [[Location alloc]initWithlocationName:@"箭竹海" voice:@""locationImageName:@"箭竹海.jpg" distance:@"1.3KM" locationText:@"箭竹(Arrow Bamboo)是大熊猫喜食的食物，箭竹海(Arrow Bamboo Lake)湖岸四周广有生长，是箭竹海最大的特点，因而得名。箭竹海湖面开阔而绵长，水色碧蓝。倒影历历，直叫人分不清究竟是山入水中还是水浸山上。"coor:(CLLocationCoordinate2D){103.879475,33.144499}];
//    Location *Location3 = [[Location alloc]initWithlocationName:@"芦苇海" voice:@""locationImageName:@"芦苇海.jpg" distance:@"1.4KM" locationText:@"“芦苇海”海拔2140米，全长2.2公里，是一个半沼泽湖泊。海中芦苇丛生，水鸟飞翔，清溪碧流，漾绿摇翠，蜿蜒空行，好一派泽国风光。“芦苇海”中，荡荡芦苇，一片青葱，微风徐来，绿浪起伏。飒飒之声，委婉抒情，使人心旷神怡。"coor:(CLLocationCoordinate2D){103.879475,33.144499}];
//    Location *Location4 = [[Location alloc]initWithlocationName:@"双龙海" voice:@""locationImageName:@"双龙海.jpg" distance:@"1.5KM" locationText:@"“双龙海”在火花海瀑布下的树丛中。海中有两条带状的生物钙华礁堤隐隐潜伏于海底，活像两条蛟龙藏于海中，蠕蠕欲动。还有一个黑龙与白龙打斗的传说。那条白龙本是双龙海的守护神，黑龙是天将，黑龙因触犯天条，被玉帝贬下界，在双龙海与白龙夺龙王大权……"coor:(CLLocationCoordinate2D){103.879475,33.144499}];
//    NSLog(@"%@",self.navigationBar.titleLabel.text);
    NSDictionary *para = @{@"scenic_area_name":self.navigationBar.titleLabel.text};
//    NSDictionary *test;
//    NSDictionary *dictWithAreaName = [[NSDictionary alloc]init];
    [HttpTool postWithparamsWithURL:@"homeInfo/GetSpotInfoWithAreaName" andParam:para success:^(id responseObject) {
        NSData *data = [[NSData alloc]initWithData:responseObject];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        DataSingleton* dataSL = [DataSingleton shareInstance];
//        dataSL.title = [[NSString alloc]initWithString:dict[@"data"][0][@"scenic_area_name"]];
//        dictWithAreaName = dict;
//        _mainDict = [[NSDictionary alloc]initWithDictionary:dict];
//        test = [[NSDictionary alloc]initWithDictionary:_mainDict];
        [self reLoad:dict];
//        NSLog(@"--------------------成功调用,%@",[dict objectForKey:@"data"]);
        //        return dict[@"data"][0][@"scenic_area_name"];
    } failure:^(NSError *error) {
        NSLog(@"附近没有景区");
        
    }];
//    NSLog(@"%@",_mainDict);
//    DataSingleton* dataSL = [DataSingleton shareInstance];
//    NSArray* data1 = @[@"卧龙海.jpeg",@"卧龙海2.jpeg",@"卧龙海3.jpeg",@"卧龙海4.jpeg"];
//    NSArray* data2 = @[@"箭竹海.jpg",@"箭竹海2.jpeg",@"箭竹海3.jpeg",@"箭竹海4.jpeg"];
//    NSArray* data3 = @[@"芦苇海.jpg",@"芦苇海2.jpeg",@"芦苇海3.jpeg"];
//    NSArray* data4 = @[@"双龙海.jpg",@"双龙海2.jpeg",@"双龙海3.jpeg",@"双龙海4.jpeg"];
//    dataSL.allImgWithLocation = @[data1,data2,data3,data4];
//    dataSL.allDetail = @[Location1,Location2,Location3,Location4];
//    self.dataArr = @[Location1,Location2,Location3,Location4];
}

////结束代理
//- (void) onCompleted:(IFlySpeechError *) error{
//    [_iFlySpeechSynthesizer stopSpeaking];
//    _iFlySpeechSynthesizer.delegate = nil;
//}
////合成开始
//- (void) onSpeakBegin{}
////合成缓冲进度
//- (void) onBufferProgress:(int) progress message:(NSString *)msg{} //合成播放进度
//- (void) onSpeakProgress:(int) progress{}
//

#pragma mark - LocationInfoCell的代理

- (IBAction)voiceBtnClick:(UIButton*)btn{
    //    NSLog(@"%ld",self.voiceBtn.tag);
    if (_isPlaying==-1) {
//        DataSingleton *dataSL = [DataSingleton shareInstance];
//        long key = self.voiceBtn.tag;
//        NSNumber *ok =[[NSNumber alloc]initWithBool:YES];
//        [dataSL.allVoiceIsPlaying replaceObjectAtIndex:key withObject:ok];
        //1.创建合成对象
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance]; _iFlySpeechSynthesizer.delegate =
        self;
        
        //设置在线工作方式
        [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                      forKey:[IFlySpeechConstant ENGINE_TYPE]];
        //音量,取值范围 0~100
        [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]]; //发音人,默认为”xiaoyan”,可以设置的参数列表可参考“合成发音人列表” [_iFlySpeechSynthesizer setParameter:@" xiaoyan " forKey: [IFlySpeechConstant VOICE_NAME]]; //保存合成文件名,如不再需要,设置设置为nil或者为空表示取消,默认目录位于 library/cache下
        [_iFlySpeechSynthesizer setParameter:@" tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
        //3.启动合成会话
        //    [IFlySpeechUtility createUtility:@"你好,我是科大讯飞的小燕"];
        [_iFlySpeechSynthesizer startSpeaking: btn.titleLabel.text];
//
        [btn setBackgroundImage:[UIImage imageNamed:@"54C5D57F9705BCC1D0486DB7D059E2E3.png"] forState:UIControlStateNormal];
        _isPlaying = btn.tag;
        
    }else if(_isPlaying==btn.tag){
        [_iFlySpeechSynthesizer stopSpeaking];
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:_isPlaying inSection:0];
        LocationInfoCell *preCell = [_mainTVC.tableView cellForRowAtIndexPath:index];
        [preCell.voiceBtn setBackgroundImage:[UIImage imageNamed:@"旅游助手－播放语音.png"] forState:UIControlStateNormal];
        _isPlaying = -1;
    }else{
        [_iFlySpeechSynthesizer stopSpeaking];
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:_isPlaying inSection:0];
        LocationInfoCell *preCell = [_mainTVC.tableView cellForRowAtIndexPath:index];
        [preCell.voiceBtn setBackgroundImage:[UIImage imageNamed:@"旅游助手－播放语音.png"] forState:UIControlStateNormal];
        
        //1.创建合成对象
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance]; _iFlySpeechSynthesizer.delegate =
        self;
        
        //设置在线工作方式
        [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                      forKey:[IFlySpeechConstant ENGINE_TYPE]];
        //音量,取值范围 0~100
        [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]]; //发音人,默认为”xiaoyan”,可以设置的参数列表可参考“合成发音人列表” [_iFlySpeechSynthesizer setParameter:@" xiaoyan " forKey: [IFlySpeechConstant VOICE_NAME]]; //保存合成文件名,如不再需要,设置设置为nil或者为空表示取消,默认目录位于 library/cache下
        [_iFlySpeechSynthesizer setParameter:@" tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
        //3.启动合成会话
        //    [IFlySpeechUtility createUtility:@"你好,我是科大讯飞的小燕"];
        [_iFlySpeechSynthesizer startSpeaking: btn.titleLabel.text];
        //
        [btn setBackgroundImage:[UIImage imageNamed:@"54C5D57F9705BCC1D0486DB7D059E2E3.png"] forState:UIControlStateNormal];
        _isPlaying = btn.tag;
    }
}


#pragma mark - tableView相关代理

//控制行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _cnt;
//    return self.dataArr.count;
}
//控制每一行样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"LocationInfoCell";
    LocationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
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
    
    
    cell.voiceBtn.tag = indexPath.row;
    cell.delegate = self;
//    NSNumber *ok = [[NSNumber alloc]initWithBool:NO];
//    [dataSL.allVoiceIsPlaying addObject:ok];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"LocationInfoCell" owner:nil options:nil].lastObject;
        cell.voiceBtn.tag = indexPath.row;
        [cell setImageViewClickBlock:^(UIButton *btn,NSString *locationName,NSString* img,NSString* locationText) {
            DetailViewController *deVC = [[DetailViewController alloc]init];
            deVC.titleText = locationName;
            deVC.detailImg = img;
            deVC.detailText = locationText;
            
            [self.navigationController pushViewController:deVC animated:YES];
        }];
        
//        cell = [[NSBundle mainBundle] loadNibNamed:@"LocationInfoCell" owner:nil options:nil].lastObject;
        
    }
    Location *currentLocation =self.dataArr[indexPath.row];
    //        CellFrameInfo *currentFrameInfo = [[CellFrameInfo alloc]initWithStudent:currentStudent];
    [cell setCellData:currentLocation];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%@",indexPath);
//    NSLog(@"%ld",(long)indexPath.row);
//    if (indexPath.row==0) {
//        return 64;
//    }
    return [LocationInfoCell returnCellHeight];
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DetailViewController *detailViewController = [[DetailViewController alloc]init];
//    detailViewController.titleText = locationName;
//    detailViewController.detailImg = img;
//    detailViewController.detailText = locationText;
    [self.navigationController pushViewController:detailViewController animated:YES ];
    
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    printf("velocity.x = %f,velocity.y = %f\n",velocity.x,velocity.y);
    printf("targetContentOffset->x = %f,targetContentOffset->y = %f\n",targetContentOffset->x,targetContentOffset->y);
//    NSLog(@"%@",targetContentOffset);
    CGFloat time = 0.5;
    if (targetContentOffset->y==0.0&&velocity.y<0) {
        if (self.navigationBar.hidden == NO) {
            return;
        }else{
            self.navigationBar.hidden = NO;
            self.navigationBar.alpha = 0;
            [UIView animateWithDuration:time animations:^{
                self.navigationBar.alpha = 1;
                self.mainTVC.tableView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64);
                
            }completion:^(BOOL finished) {
                
                
            }];
            return;
        }
    }
    if(velocity.y>0)
    {
        self.navigationBar.alpha = 1;
        [UIView animateWithDuration:time animations:^{
            self.mainTVC.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            self.navigationBar.alpha = 0;
        }completion:^(BOOL finished) {
            
            self.navigationBar.hidden = YES;
        }];
        
    }
    else if(velocity.y<0)
    {
        self.navigationBar.hidden = NO;
        self.navigationBar.alpha = 0;
        [UIView animateWithDuration:time animations:^{
            self.navigationBar.alpha = 1;
            self.mainTVC.tableView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64);
            
        }completion:^(BOOL finished) {
            
            
        }];
        
    }
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView  {
//    NSLog(@"%@",scrollView);
//    NSLog(@"_tableViewPosPre = %f",_tableViewPosPre);
//    //向下滑动
//    if (scrollView.contentOffset.y==_tableViewPosPre) {
//        return;
//    }
//    
//    if (scrollView.contentOffset.y-_tableViewPosPre>1) {
//        //1.执行动画
//        self.navigationBar.alpha = 1;
//        [UIView animateWithDuration:1 animations:^{
//            self.navigationBar.alpha = 0;
//        }];
//        
//    }
//    //向上滑动
//    else if(_tableViewPosPre-scrollView.contentOffset.y>1){
//        [self.view addSubview:self.navigationBar];
//        [UIView animateWithDuration:0.5 animations:^{
//                //            mapUpView.frame = CGRectMake(0, screenHeight-kUpViewHeight,screenWidth, kUpViewHeight);
//                self.navigationBar.transform = CGAffineTransformMakeTranslation(0, 0);
//            }];
//    }
//    
//    _tableViewPosPre = scrollView.contentOffset.y;
////    [self.view addSubview:_mapUpView];
////    [UIView animateWithDuration:0.3 animations:^{
////        //            mapUpView.frame = CGRectMake(0, screenHeight-kUpViewHeight,screenWidth, kUpViewHeight);
////        _mapUpView.transform = CGAffineTransformMakeTranslation(0, -kUpViewHeight);
////    }];
//    
//    
//    
//    
//}


#pragma mark - 导航栏按钮点击事件

- (void)leftBtnDidClick:(UIButton *)leftBtn{
    NSLog(@"HOME leftBtnDidClick");
    
//    if (_state==Playing) {
//        [_iFlySpeechSynthesizer stopSpeaking];
//        _state = NotStart;
//    }
    
    MapViewController *mapViewController;
    mapViewController = [[MapViewController alloc]init];
    mapViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    mapViewController.titleText = self.navigationBar.titleLabel.text;
    
    [self presentViewController:mapViewController animated:YES completion:nil];

}

- (void)rightBtnDidClick:(UIButton *)rightBtn{
    SetingViewController *setingVC = [[SetingViewController alloc]init];
    [self.navigationController pushViewController:setingVC animated:YES];
//    [self.navigationController pushViewController:setingVC animated:YES ];
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




#pragma mark - 网络接口


- (void) getAreaName{
//    _locService.userLocation.location.coordinate.latitude
    NSString *latitude = [NSString stringWithFormat:@"%f",_locService.userLocation.location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",_locService.userLocation.location.coordinate.longitude];
//    NSLog(@"%f %f",_locService.userLocation.location.coordinate.latitude,_locService.userLocation.location.coordinate.longitude);
//    NSLog(@"%@ %@",latitude,longitude);
    NSDictionary *para = @{@"scenic_area_latitude":latitude,
                           @"scenic_area_longitude":longitude};
    
    [HttpTool postWithparamsWithURL:@"homeInfo/GetScenicAreaName" andParam:para success:^(id responseObject) {
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
            [self.navigationBar.titleLabel setText:dict[@"data"][0][@"scenic_area_name"]];
            [self loadDataFromWeb];
        }
        
        //= dict[@"data"][0][@"scenic_spot_name"];
//        NSLog(@"%@",self.navigationBar.titleLabel.text);
        
//        NSLog(@"成功调用,%@",dict[@"data"][0]);
//        return dict[@"data"][0][@"scenic_area_name"];
    } failure:^(NSError *error) {
        NSLog(@"网络数据接受错误");

    }];
    
}

- (void) getSpotInfoWordForWeb{
    
    NSDictionary *para = @{@"scenic_area_name":@"测试景区"};
    
    [HttpTool postWithparamsWithURL:@"homeInfo/GetSpotWordInfoWithAreaName" andParam:para success:^(id responseObject) {
//        NSData *data = [[NSData alloc]initWithData:responseObject];
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"成功调用,%@",dict[@"data"][0][@"scenic_spot_name"]);
        
    } failure:^(NSError *error) {
        NSLog(@"附近没有景区");
        
    }];
    
}

- (void) GetSpotImgInfoWithSpotName{
    
    NSDictionary *para = @{@"scenic_spot_name":@"测试景点"};
    
    [HttpTool postWithparamsWithURL:@"homeInfo/GetSpotImgInfoWithSpotName" andParam:para success:^(id responseObject) {
        NSData *data = [[NSData alloc]initWithData:responseObject];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"成功调用,%@",dict);
        
    } failure:^(NSError *error) {
        NSLog(@"景点没有图片");
        
    }];
    
}



@end
