//
//  ViewController.m
//  CYKitDemo
//
//  Created by 成焱 on 2017/2/19.
//  Copyright © 2017年 cheng.yan. All rights reserved.
//

#import "ViewController.h"
#import "CYKit.h"
#import "CYNetworkCommand.h"
#import "ReactiveObjC.h"
#import "NSObject+CYAddition.h"
#import "SYArticleModel.h"
@interface ViewController ()
@property (nonatomic, strong) CYNetworkCommand *command;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"name = %@",[CYModel className]);
    
    NSString *url = @"https://paytest.sooyie.cn/Controller/service/Client2.ashx?action=GetSplashScreen";
    NSDictionary *param = @{@"scale":@"16_9"};
    
    
    
    [RACObserve(self.command, data) subscribeNext:^(id  _Nullable x) {
        DDLogInfo(@"x = %@",x);
    }];
    
    [self.command.getCommand execute:@{k_CY_URL:url,k_CY_PARAMS:param}];
    
    SYArticleModel *article = [SYArticleModel cy_shareInstance];
    article.Author = @"成焱";
    [article cy_save];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (CYNetworkCommand *)command
{
    if (!_command) {
        _command = [CYNetworkCommand new];
    }
    return _command;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
