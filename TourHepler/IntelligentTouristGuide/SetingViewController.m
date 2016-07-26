//
//  SetingViewController.m
//  IntelligentTouristGuide
//
//  Created by Student04 on 16/7/14.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "SetingViewController.h"
#define screenWidth ([UIScreen mainScreen].bounds.size.width)
#define screenHeight ([UIScreen mainScreen].bounds.size.height)
#define kTVTopMargins (546.0/1920.0*screenHeight)
#define kTVLeftMargins (120.0/1080.0*screenWidth)
#define kTVWidth (831.0/1080.0*screenWidth)
#define kTVheight (961.0/1920.0*screenHeight)
#define kLineMargins (40.0/1080.0*screenWidth)
#define kLineHeight 1

@interface SetingViewController ()

@property ( nonatomic , strong ) UILabel * cachLabel;//显示缓存有多少m

@end

@implementation SetingViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.navigationController setNavigationBarHidden:YES];
        self.navigationBar.titleLabel.text = @"个人设置";
        [self.navigationBar.leftBtn setImage:[UIImage imageNamed:@"旅游助手－返回.png"] forState:UIControlStateNormal];
        [self.navigationBar.rightBtn setHidden:YES];
        //背景
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight-64)];
        UIColor *backViewColor = [UIColor colorWithRed:35.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1];
        backView.backgroundColor = backViewColor;
        [self.view addSubview:backView];
        
        //按钮背景
        UIView *cellBackView = [[UIView alloc]initWithFrame:CGRectMake(kTVLeftMargins, kTVTopMargins, kTVWidth, kTVheight)];
        UIColor *cellBackViewColor = [UIColor colorWithRed:43.0/255.0 green:162.0/255.0 blue:145.0/255.0 alpha:1];
        cellBackView.layer.masksToBounds = YES;
        cellBackView.layer.cornerRadius = 6.0;
        cellBackView.layer.borderWidth = 1.0;
        cellBackView.layer.borderColor = [cellBackViewColor CGColor];
        cellBackView.backgroundColor = cellBackViewColor;
        [self.view addSubview:cellBackView];
        
        
        UIButton *cleanBtn = [[UIButton alloc]initWithFrame:CGRectMake(kTVLeftMargins, kTVTopMargins, kTVWidth, kTVheight/3.0)];
        [cleanBtn setTitle:@"清除缓存" forState:UIControlStateNormal];
        [cleanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cleanBtn.backgroundColor = [UIColor clearColor];
        [cleanBtn addTarget:self action:@selector(cleanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cleanBtn];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(kTVLeftMargins+kLineMargins, kTVTopMargins+kTVheight/3.0, kTVWidth-2*kLineMargins, kLineHeight)];
        line1.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:line1];
        
        UIButton *subBtn = [[UIButton alloc]initWithFrame:CGRectMake(kTVLeftMargins, kTVTopMargins+kTVheight/3.0, kTVWidth, kTVheight/3.0)];
        [subBtn setTitle:@"提出意见" forState:UIControlStateNormal];
        [subBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        subBtn.backgroundColor = [UIColor clearColor];
        [subBtn addTarget:self action:@selector(subBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:subBtn];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(kTVLeftMargins+kLineMargins, kTVTopMargins+2*kTVheight/3.0, kTVWidth-2*kLineMargins, kLineHeight)];
        line2.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:line2];
        
        UIButton *aboutBtn = [[UIButton alloc]initWithFrame:CGRectMake(kTVLeftMargins, kTVTopMargins+2*kTVheight/3.0, kTVWidth, kTVheight/3.0)];
        [aboutBtn setTitle:@"关于我们" forState:UIControlStateNormal];
        [aboutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        aboutBtn.backgroundColor = [UIColor clearColor];
        [aboutBtn addTarget:self action:@selector(aboutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:aboutBtn];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)aboutBtnClick:(UIButton*)sender{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"关于我们"
                              message:@"天津理工大学管理学院"
                              delegate:nil
                              cancelButtonTitle:@"好的"
                              otherButtonTitles:nil
                              ];
    [alertView show];
    
    
//    SetingAboutViewController *aboutVC = [[SetingAboutViewController alloc]init];
//    [self.navigationController pushViewController:aboutVC animated:YES ];
}

- (void)subBtnClick:(UIButton*)sender{
    SetingSubViewController * subVC = [[SetingSubViewController alloc]init];
    [self.navigationController pushViewController:subVC animated:YES ];
}

- (void)leftBtnDidClick:(UIButton *)leftBtn{
//    NSLog(@"leftBtnDidClick");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 清理缓存

- (void)cleanBtnClick:(UIButton*)sender{
    _cachLabel = [[UILabel alloc]init];
    _cachLabel.text = [[NSString alloc]initWithFormat:@"%.2f", [self filePath]];
    NSString *display = @"一共有";
    display=[display stringByAppendingString:_cachLabel.text];
    display=[display stringByAppendingString:@"M的缓存文件"];
    UIAlertView * alertView = [[ UIAlertView alloc ] initWithTitle : @" 提示 " message :display  delegate : self cancelButtonTitle : @" 取消 " otherButtonTitles :@"清理", nil ];
    
    [alertView show];
    NSLog(@"%@",_cachLabel.text);
    
}



//1:首先我们计算一下 单个文件的大小

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
        
    }
    
    return 0 ;
    
}

//2: 遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）

- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    return folderSize/( 1024.0 * 1024.0 );
    
}

// 显示缓存大小

- ( float )filePath

{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    return [ self folderSizeAtPath :cachPath];
    
}

// 清理缓存

- ( void )clearFile

{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
//    NSLog ( @"cachpath = %@" , cachPath);
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            
        }
        
    }
    
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject :nil waitUntilDone : YES ];
    
}

- ( void )clearCachSuccess

{
    
//    NSLog ( @" 清理成功 " );
    
    UIAlertView * alertView = [[ UIAlertView alloc ] initWithTitle : @" 提示 " message : @"清理成功" delegate : nil cancelButtonTitle : @" 好的 " otherButtonTitles : nil ];
    
    [alertView show];
//    [ _tableView reloadData ];//清理完之后重新导入数据
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSLog(@"%li",(long)buttonIndex);
    if (1==buttonIndex) {
        [self clearFile];
    }
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
