//
//  HomeViewController.m
//  CYKitDemo
//
//  Created by chengyan on 17/3/20.
//  Copyright © 2017年 cheng.yan. All rights reserved.
//

#import "HomeViewController.h"
#import <CYKit/UIImage+CYAddtion.h>
#import <CYKit/UIDevice+CYAddition.h>
#import <CYKit/UIColor+CYAddition.h>
#import <CYKit/NSString+CYAddition.h>
#import <CYKit/NSData+CYAddition.h>
#import "ReactiveObjC.h"
#import "UIView+CYAddition.h"

#import "NSObject+CYAddition.h"
#import "SYArticleModel.h"

@interface HomeViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor grayColor];
    // Do any additional setup after loading the view.
    
    UIColor *color = [UIColor cy_randomColor];
    
    NSString *devicename = [UIDevice cy_deviceName];
    NSString *macaddress = [UIDevice cy_macAddress];
    NSString *ipaddress = [UIDevice cy_ipAddressCell];
    NSString *carriername = [UIDevice cy_carrier];
    
    UIImage *image = [UIImage cy_imageByPureColor:[UIColor redColor] size:CGSizeMake(10, 100)];
    
    NSNumber *fileSye = [UIDevice cy_totalDeviceSize];
    NSNumber *fileFre = [UIDevice cy_freeDeviceSize];
    
    BOOL isJailBroken = [UIDevice cy_isJailBroken];
    if (isJailBroken==NO) {
        NSLog(@"333");
    }
    
    NSDate *date1 = [NSDate date];



    NSDate *date2 = [NSDate date];
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1] * 1000.f;
    NSLog(@"%s 消耗时间为 %.2f 毫秒",__func__,time);
    DDLogInfo(@"110");
    DDLogError(@"2220");
    
    UIView *view = [UIView new];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.height.with.width.offset(100);
    }];
    view.backgroundColor = [UIColor blueColor];
    [view cy_cornerRound:UIRectCornerTopLeft | UIRectCornerTopRight size:CGSizeMake(50, 50)];
    
    
    NSString *url = @"https://paytest.sooyie.cn/Controller/service/Client2.ashx?action=GetSplashScreen";
    NSDictionary *param = @{@"scale":@"16_9"};
    
    DDLogInfo(@"objs = %@",[param objectForKey:@"12"]);
    
    
    
//    [self.command.getCommand execute:@{k_CY_URL:url,k_CY_PARAMS:param}];
//    [self.command.postCommand execute:@{k_CY_URL:url,k_CY_PARAMS:param}];

    

//    NSDate *date1 = [NSDate date];
//
//    NSArray *historys = [CYHistory findAll];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == '7'"];
//    NSArray *result = [historys filteredArrayUsingPredicate:predicate];
//    NSLog(@"result = %@",result);
//    if (result.count!=0){
//        CYHistory *history = [result firstObject];
//        history.desc = @"10086";
//        for (int i = 0; i < 1000; i++){
//        [history save];
//        }
//
//    }
//
//
//
//    NSDate *date2 = [NSDate date];
//    NSTimeInterval time = [date2 timeIntervalSinceDate:date1] * 1000.f;
//    NSLog(@"%s 消耗时间为 %.2f 毫秒",__func__,time);
    
//    [YCDBVideo dropTable];
    
    SYArticleModel *article = [SYArticleModel cy_shareInstance];
//    article.Author = @"成焱";
//    [article cy_save];
    NSLog(@"artileName:%@",article.Author);
    [article cy_clean];
//    [article cy_save];
    [self becomeFirstResponder];
    NSLog(@"if %d",[self isFirstResponder]);
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];

    UIView * firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    NSLog(@"----%@",firstResponder);


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
