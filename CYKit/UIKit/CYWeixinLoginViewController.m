//
//  SYWeixinLoginViewController.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/20.
//  Copyright © 2019 sy. All rights reserved.
//

#import "CYWeixinLoginViewController.h"
#import "CYH5ViewController.h"
#import "CYLaunchViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "Masonry.h"
#import "CYKitDefines.h"
#import "ReactiveObjC.h"
#import "BlocksKit+UIKit.h"
#import "XHToast.h"

//#import "WXApi.h"
@interface CYWeixinLoginViewController ()


@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *phoneIcon;
@property (nonatomic, strong) UIImageView *passwordIcon;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIImageView *eyeIcon;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *scanRegBtn;
@property (nonatomic, strong) UIButton *userRegBtn;
@property (nonatomic, strong) UILabel *scanLbl;
@property (nonatomic, strong) UILabel *userLbl;
@property (nonatomic, strong) UILabel *fogotPasswordLbl;
@property (nonatomic, strong) NSNumber *securityInput;
@property (nonatomic, assign) BOOL isScanRegiste;
@end

@implementation CYWeixinLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shouldShowHeader = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpSubviews];
    [self setConstaints];
    [self bindData];
    self.securityInput = @(YES);

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void) setUpSubviews
{
    self.topImageView = [UIImageView new];
    self.topImageView.image = [UIImage imageNamed:@"sy_login_header"];
    [self.view addSubview:self.topImageView];

    
    self.logoImageView = [UIImageView new];
    self.logoImageView.image = [UIImage imageNamed:@"sy_login_logo"];
    self.logoImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.logoImageView];

    
    self.phoneIcon = [UIImageView new];
    self.phoneIcon.image = [UIImage imageNamed:@"sy_login_phone"];
    [self.view addSubview:self.phoneIcon];

    
    self.passwordIcon = [UIImageView new];
    self.passwordIcon.image = [UIImage imageNamed:@"sy_login_password"];
    [self.view addSubview:self.passwordIcon];

    
    self.phoneTextField = [UITextField new];
    self.phoneTextField.borderStyle = UITextBorderStyleNone;
    self.phoneTextField.placeholder = @"请输入您的手机号码";
//    self.phoneTextField.tintColor = k_Color_CustomRed;
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    
    [self.view addSubview:self.phoneTextField];
    
    self.line1 = [UIView new];
    self.line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.line1];

    
    self.eyeIcon = [UIImageView  new];
    self.eyeIcon.image = [UIImage imageNamed:@"sy_login_close_eye"];
    self.eyeIcon.highlightedImage = [UIImage imageNamed:@"sy_login_open_eye"];
    self.eyeIcon.userInteractionEnabled = YES;
    self.eyeIcon.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.eyeIcon];
    
    self.passwordTextField = [UITextField new];
    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.passwordTextField.placeholder = @"请输入您的密码";
    self.passwordTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    [self.view addSubview:self.passwordTextField];

    self.fogotPasswordLbl = [UILabel new];
    self.fogotPasswordLbl.textColor = [UIColor lightGrayColor];
    self.fogotPasswordLbl.text = @"忘记密码";
    self.fogotPasswordLbl.font = [UIFont systemFontOfSize:15.f];
    self.fogotPasswordLbl.userInteractionEnabled = YES;
    [self.view addSubview:self.fogotPasswordLbl];
    
    self.line2 = [UIView new];
    self.line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.line2];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.loginBtn.layer.cornerRadius = 20.f;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.loginBtn];

    
    self.scanRegBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scanRegBtn setImage:[UIImage imageNamed:@"sy_login_scan"] forState:UIControlStateNormal];
    [self.view addSubview:self.scanRegBtn];
    
    self.scanLbl = [UILabel new];
    self.scanLbl.text = @"扫码注册";
    self.scanLbl.font = [UIFont systemFontOfSize:14.f];
    self.scanLbl.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.scanLbl];
    
    self.userRegBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.userRegBtn setImage:[UIImage imageNamed:@"sy_login_avator"] forState:UIControlStateNormal];
    [self.view addSubview:self.userRegBtn];

    self.userLbl = [UILabel new];
    self.userLbl.text = @"新用户注册";
    self.userLbl.font = [UIFont systemFontOfSize:14.f];
    self.userLbl.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.userLbl];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void) setConstaints
{
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(180+CY_Height_StatusBar);
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(104);
        make.top.mas_equalTo(self.topImageView.mas_bottom).offset(-52);
        make.centerX.offset(0);
    }];
    
    [self.phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.top.mas_equalTo(self.logoImageView.mas_bottom).offset(40);
        make.width.offset(11);
        make.height.offset(15);
    }];

    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.phoneIcon);
        make.left.mas_equalTo(self.phoneIcon.mas_right).offset(20);
        make.right.offset(-50);
        make.height.offset(50);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneIcon.mas_bottom).offset(10);
        make.left.offset(50);
        make.right.offset(-50);
        make.height.offset(CY_Sigle_Line_Height);
    }];
    
    [self.passwordIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.top.mas_equalTo(self.phoneIcon.mas_bottom).offset(40);
        make.width.offset(12);
        make.height.offset(14);
    }];
    
    

    [self.eyeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-50);
        make.centerY.mas_equalTo(self.passwordIcon);
        make.width.height.offset(40);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.passwordIcon.mas_right).offset(20);
        make.right.mas_equalTo(self.eyeIcon.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.eyeIcon);
        make.height.offset(50);
    }];

    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordIcon.mas_bottom).offset(10);
        make.left.offset(50);
        make.right.offset(-50);
        make.height.offset(CY_Sigle_Line_Height);
    }];
    
    [self.fogotPasswordLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-50);
        make.top.mas_equalTo(self.line2.mas_bottom).offset(15);
    }];

    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(55.f);
        make.right.offset(-55.f);
        make.height.offset(40);
        make.top.mas_equalTo(self.line2.mas_bottom).offset(50);
    }];
    
    [self.scanLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-(CY_Height_Bottom_SafeArea + 15));
        make.centerX.offset(-50);
    }];
    
    [self.scanRegBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.scanLbl);
        make.bottom.mas_equalTo(self.scanLbl.mas_top).offset(-15);
    }];
    
    [self.userRegBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.userLbl);
        make.bottom.mas_equalTo(self.userLbl.mas_top).offset(-15);
    }];
    
    [self.userLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-(CY_Height_Bottom_SafeArea + 15));
        make.centerX.offset(50);
    }];
}


- (void) bindData
{
    @weakify(self);
    [self.eyeIcon bk_whenTapped:^{
        @strongify(self);
        if ([self.securityInput boolValue] == YES) {
            self.securityInput = @(NO);
        }
        else{
            self.securityInput = @(YES);
        }
    }];
    
    [RACObserve(self, securityInput) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.passwordTextField.secureTextEntry = [x boolValue];
        self.eyeIcon.highlighted = [x boolValue];
    }];
    
    [self.logoImageView bk_whenTapped:^{
        @strongify(self);
        self.loginBlock?self.loginBlock(CYWexinLoginType_LogoImage):nil;
    }];
    
    
    [[[self.phoneTextField rac_textSignal] combineLatestWith:[self.passwordTextField rac_textSignal]] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        RACTuple *tuple = (RACTuple *)x;
        NSString *phone = [tuple first];
        if (phone.length > 11) {
            self.phoneTextField.text = [phone substringToIndex:11];
        }
    }];
    
    [self.loginBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        // 登录
        
        self.loginBlock?self.loginBlock(CYWexinLoginType_Login):nil;
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.scanRegBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        
        self.loginBlock?self.loginBlock(CYWexinLoginType_Scan):nil;
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.userRegBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.isScanRegiste = NO;
        self.loginBlock?self.loginBlock(CYWexinLoginType_NewUser):nil;
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.fogotPasswordLbl bk_whenTapped:^{
        @strongify(self);
        self.loginBlock?self.loginBlock(CYWexinLoginType_FogetPassword):nil;
    }];
}




@end













