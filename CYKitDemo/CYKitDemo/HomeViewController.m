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
#import <CYKit/CYPrivateView.h>
#import "NSObject+CYAddition.h"
#import "SYArticleModel.h"
#import "Masonry.h"
#import <CYKit/CYH5ViewController.h>
@interface HomeViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITextView *agreementTextView;
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

    [CYPrivateView showOn:self.view finishBlock:^(NSInteger idx) {
        if (idx == 2) {
            CYH5ViewController *h5 = [[CYH5ViewController alloc] init];
            h5.urlString = @"http://www.baidu.com";
            [self.navigationController pushViewController:h5 animated:YES];
        }else if (idx == 3){
            CYH5ViewController *h5 = [[CYH5ViewController alloc] init];
            h5.urlString = @"http://www.baidu.com";
            [self.navigationController pushViewController:h5 animated:YES];
        }
    }];

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

//- (void)viewDidLoad {
//
//    _agreementTextView = [[UITextView alloc] init];
//    _agreementTextView.text = @"我已阅读并同意《俄语阅读用户服务协议》";
//    _agreementTextView.backgroundColor = [UIColor yellowColor];
//    _agreementTextView.textColor = RGBA(142, 142, 142, 1);
//    _agreementTextView.textAlignment = NSTextAlignmentCenter;
//    _agreementTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    _agreementTextView.font = [UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width/375*11 weight:UIFontWeightRegular];
//    _agreementTextView.showsVerticalScrollIndicator = NO;
//    _agreementTextView.scrollEnabled = NO;
//    _agreementTextView.editable = NO;
////    _agreementTextView.selectable = NO;
//    self.agreementTextView.delegate = self;
//    [self.view addSubview:self.agreementTextView];
//    [self.agreementTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.offset(CY_Height_NavBar+ 40);
//        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width/375*235);
//        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.width/375*13);
//    }];
//    [self agreementSetupHanle];
//}
//
//- (void)agreementSetupHanle {
//
//    NSString *agreementMessage = self.agreementTextView.text;
//
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:agreementMessage];
//
//    [attributedString addAttribute:NSLinkAttributeName
//                             value:@"2"
//                             range:[[attributedString string] rangeOfString:@"《俄语阅读用户服务协议》"]];
//    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width/375*11] range:[[attributedString string] rangeOfString:agreementMessage]];
//
//    [attributedString addAttribute:NSForegroundColorAttributeName value:RGBA(142, 142, 142, 1) range:[[attributedString string] rangeOfString:agreementMessage]];
//    self.agreementTextView.linkTextAttributes = @{ NSForegroundColorAttributeName: [UIColor colorWithRed:75.0/255.0 green:168.0/255.0 blue:161.0/255.0 alpha:1],
//                                                  NSUnderlineColorAttributeName: [UIColor clearColor],
//                                                  NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
//
//    // 设置间距
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = 5;// 字体的行间距
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:[[attributedString string] rangeOfString:agreementMessage]];
//
//    self.agreementTextView.attributedText = attributedString;
//
//}
//
//- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
//
//    if ([URL.absoluteString  isEqualToString:@"2"]) {
////        CheckUserAgreementCTRL *agreementVC = [[CheckUserAgreementCTRL alloc] init];
////        agreementVC.originMark = 2;
////        [self.navigationController pushViewController:agreementVC animated:YES];
//
//    }
//    return YES;
//
//}
//
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//    // 禁用文本复制、粘贴
//    return NO;
//}


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
