//
//  ViewController.m
//  CYKitDemo
//
//  Created by 成焱 on 2017/2/19.
//  Copyright © 2017年 cheng.yan. All rights reserved.
//

#import "ViewController.h"
#import "CYKit.h"
#import "ReactiveObjC.h"
#import "NSObject+CYAddition.h"
#import "SYArticleModel.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *url = @"https://paytest.sooyie.cn/Controller/service/Client2.ashx?action=GetSplashScreen";
    NSDictionary *param = @{@"scale":@"16_9"};
    
    
    
    SYArticleModel *article = [SYArticleModel cy_shareInstance];
    article.Author = @"成焱";
    [article cy_save];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
