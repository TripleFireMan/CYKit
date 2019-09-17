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

#import "CYNetworkCommand.h"
#import "ReactiveObjC.h"
#import "CYSPlashCommand.h"

@interface HomeViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CYSPlashCommand *command;
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
    
    
    
    NSString *url = @"https://paytest.sooyie.cn/Controller/service/Client2.ashx?action=GetSplashScreen";
    NSDictionary *param = @{@"scale":@"16_9"};
    
    DDLogInfo(@"objs = %@",[param objectForKey:@"12"]);
    
    [[RACObserve(self.command, data) skip:1] subscribeNext:^(id  _Nullable x) {
        DDLogInfo(@"x = %@",x);
    }];
    
//    [[RACObserve(self.command, error) skip:1] subscribeNext:^(id  _Nullable x) {
//        DDLogInfo(@"errpr = %@",x);
//    }];
    
    [[RACObserve(self.command, status) skip:1]subscribeNext:^(id  _Nullable x) {
        DDLogInfo(@"x ==== %@",x);
    }];
    
    
//    [self.command.getCommand execute:@{k_CY_URL:url,k_CY_PARAMS:param}];
//    [self.command.postCommand execute:@{k_CY_URL:url,k_CY_PARAMS:param}];
    [self.command.postCommand execute:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.command.postCommand execute:@{k_CY_URL:url,k_CY_PARAMS:param}];
    });
    

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

- (CYSPlashCommand *)command
{
    if (!_command) {
        _command = [CYSPlashCommand new];
    }
    return _command;
}


@end
