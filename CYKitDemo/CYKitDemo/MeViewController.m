//
//  MeViewController.m
//  CYKitDemo
//
//  Created by chengyan on 17/3/20.
//  Copyright © 2017年 cheng.yan. All rights reserved.
//

#import "MeViewController.h"
#import "CYMeModel.h"
#import "CYH5ViewController.h"
#import "CYFeedBackViewController.h"
#import "CYWeixinLoginViewController.h"
#import "CYForgotPasswordViewController.h"
#import "CYChangePasswordViewController.h"
#import "CYLaunchViewController.h"
#import "SYHelpUsViewController.h"
#import "SYAboutUsViewController.h"
#import "SYCustomScanViewController.h"
#import "StyleDIY.h"
#import "SpeechVC.h"
#import "CYDownloadViewController.h"
#import "UIView+CYAddition.h"

@interface MeViewController () <UITableViewDelegate,UITableViewDataSource,LBXScanViewControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.dataSource = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CY_Height_NavBar);
        make.left.right.offset(0);
        make.bottom.offset(0);
    }];
    
    [self loadData];
    [self.tableView cy_adjustForIOS13];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)loadData
{
    
    NSArray *titles = @[@"H5容器",@"用户反馈",@"登录",@"启动页",@"帮助页",@"清除缓存",@"关于我们",@"扫码",@"语音播报",@"下载"];
    
    for (int i = 0; i < titles.count; i++) {
        CYMeModel *model = [CYMeModel new];
        model.title = titles[i];
        [self.dataSource addObject:model];
    }
    
    [self.tableView reloadData];
    
}

#pragma mark - tableViewDelegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DefaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CYMeModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.textLabel.text = model.title;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYMeModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    if ([model.title isEqualToString:@"H5容器"]) {
        CYH5ViewController *h5 = [[CYH5ViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        [self.navigationController pushViewController:h5 animated:YES];
    }
    else if ([model.title isEqualToString:@"用户反馈"]){
        CYFeedBackViewController *feedback = [[CYFeedBackViewController alloc] init];
        [self.navigationController pushViewController:feedback animated:YES];
    }
    else if ([model.title isEqualToString:@"登录"]){
        CYWeixinLoginViewController *login = [[CYWeixinLoginViewController alloc] init];
        login.loginBlock = ^(CYWexinLoginType type) {
            switch (type) {
                case CYWexinLoginType_FogetPassword:
                {
                    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CYKit" ofType:@"bundle"];
                    NSLog(@"bundlePath =%@",bundlePath);
                    CYChangePasswordViewController *forget =  [[CYChangePasswordViewController alloc] initWithNibName:@"CYChangePasswordViewController" bundle:[NSBundle bundleWithPath:bundlePath]];
                    [self.navigationController pushViewController:forget animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        };
        [self.navigationController pushViewController:login animated:YES];
    }
    else if ([model.title isEqualToString:@"启动页"]){
        CYLaunchViewController *launchVC = [CYLaunchViewController new];
        [self.navigationController pushViewController:launchVC animated:YES];
    }
    else if ([model.title isEqualToString:@"帮助页"]){
        SYHelpUsViewController *helpUs = [SYHelpUsViewController new];
        [self.navigationController pushViewController:helpUs animated:YES];
    }
    else if ([model.title isEqualToString:@"清除缓存"]){
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            [XHToast showBottomWithText:@"缓存清除成功"];
        });
    }
    else if ([model.title isEqualToString:@"关于我们"]){
        SYAboutUsViewController *aboutus = [[SYAboutUsViewController alloc]init];
        [self.navigationController pushViewController:aboutus animated:YES];
    }
    else if ([model.title isEqualToString:@"扫码"]){
        self.navigationController.navigationBar.hidden = YES;
        SYCustomScanViewController *scanVC = [SYCustomScanViewController new];
//        scanVC.navigationController.navigationBar.hidden = YES;
        scanVC.scanType = SYCustomScanType_ChangeCard;
        scanVC.style = [StyleDIY weixinStyle];
        scanVC.delegate = self;
        scanVC.isOpenInterestRect = YES;
        [self.navigationController pushViewController:scanVC animated:YES];
    }
    else if ([[model title] isEqualToString:@"语音播报"]){
        SpeechVC *speechVC = [SpeechVC new];
        [self.navigationController pushViewController:speechVC animated:YES];
    }
    else if ([model.title isEqualToString:@"下载"]){
        CYDownloadViewController *downloadVC = [CYDownloadViewController new];
        [self.navigationController pushViewController:downloadVC animated:YES];
    }
}

- (void) scanResultWithArray:(NSArray<LBXScanResult *> *)array
{
    LBXScanResult *obj = [array firstObject];
    if (obj) {
        
        NSString *string = obj.strScanned;
        [XHToast showBottomWithText:string];
        [self.navigationController popViewControllerAnimated:YES];
//        NSString *lastContent = [string lastPathComponent];
//
//        NSData *data = [[NSData alloc]initWithBase64EncodedString:lastContent options:NSDataBase64DecodingIgnoreUnknownCharacters];
//
//        NSString *decodeBase64String = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//
//        NSString *newMchID = decodeBase64String;
//
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        [params setObject:newMchID forKey:@"newMerchantID"];
//        [params setObject:[SYUser currentUser].ID?:@"" forKey:@"oldMerchantID"];
//        NSLog(@"params : %@",params);
//        [HttpTool GETWithAction:ACTION_CHANGE_CARD content:params HUD:YES successWithStatus:^(id data, NSInteger statusCode, NSString *msg) {
//            if (statusCode == k_SuoYiInterfaceSuccessCode) {
//                [XHToast showBottomWithText:@"换码成功"];
//                //将所有信息都更新一遍
//                [[SYUser currentUser] loginWithJsonObject:data];
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//            else{
//                if ([msg isKindOfClass:[NSString class]] && msg.length!=0) {
//                    [XHToast showBottomWithText:msg];
//                }
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//        } failure:^(NSError *error) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
    }
}


@end










