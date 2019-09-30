//
//  SYCustomScanViewController.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/14.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYCustomScanViewController.h"
#import "StyleDIY.h"
@interface SYCustomScanViewController ()
/// 头部视图
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *heaerImageView;
@property (nonatomic, strong) UILabel *payMoneyLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UIButton *flusBtn;

@end

@implementation SYCustomScanViewController
- (instancetype) init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView = [UIView new];
    self.navigationController.navigationBarHidden = YES;
    self.headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.offset(CY_Height_NavBar);
    }];
    NSLog(@"k_Height_NavBar=%@ size=%@",@(CY_Height_NavBar),NSStringFromCGSize([[UIScreen mainScreen] currentMode].size));
    
    self.heaerImageView =[UIImageView new];
    self.heaerImageView.image = [UIImage imageNamed:@"sy_navi_bar"];
    self.heaerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.heaerImageView.clipsToBounds = YES;
    self.heaerImageView.hidden = YES;
    [self.headerView addSubview:self.heaerImageView];
    [self.heaerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    
    [self.headerView addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.offset(-5);
        make.height.width.offset(40);
    }];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"扫一扫";
    [self.headerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backBtn);
        //        make.centerX.mas_equalTo(self.headerView);
        make.left.mas_equalTo(self.backBtn.mas_right).offset(10);
        make.right.offset(-60);
    }];
    [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    if (self.payMoney!=0) {
        self.payMoneyLabel = [UILabel new];
        self.payMoneyLabel.textColor = [UIColor whiteColor];
        self.payMoneyLabel.font = [UIFont systemFontOfSize:20.f];
        [self.view addSubview:self.payMoneyLabel];
        self.payMoneyLabel.text = [NSString stringWithFormat:@"￥%.2lf",self.payMoney];
        [self.payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(CY_Height_NavBar+ 50);
            make.centerX.offset(0);
        }];
    }
    
    self.desLabel = [UILabel new];
    self.desLabel.font = [UIFont systemFontOfSize:15];
    self.desLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.desLabel];
    self.desLabel.text = @"请对准二维码进行扫描";

    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(-60);
    }];
    
    self.flusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.flusBtn setBackgroundImage:[UIImage imageNamed:@"sy_flush_off"] forState:UIControlStateNormal];
    [self.flusBtn setBackgroundImage:[[UIImage imageNamed:@"sy_flush_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
    self.flusBtn.selected = [self isOpenFlash];
    self.flusBtn.tintColor = [UIColor colorWithRed:0./255 green:200./255. blue:20./255. alpha:1.0];
    
    [self.view addSubview:self.flusBtn];
    [self.flusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.mas_equalTo(self.desLabel.mas_top).offset(-50);
        make.width.offset(32.5);
        make.height.offset(50);
    }];
    @weakify(self);
    [self.flusBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        if ([self isOpenFlash]) {
            self.flusBtn.selected = NO;
        }
        else{
            self.flusBtn.selected = YES;
        }
        [self openOrCloseFlash];
    } forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view bringSubviewToFront:self.headerView];
    [self.view bringSubviewToFront:self.payMoneyLabel];
    [self.view bringSubviewToFront:self.desLabel];
    [self.view bringSubviewToFront:self.flusBtn];
}

- (void)backbtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if ([self.delegate respondsToSelector:@selector(scanResultWithArray:)]) {
        [self.delegate scanResultWithArray:array];
    }
    
//    [self.navigationController popViewControllerAnimated:YES];
    
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
