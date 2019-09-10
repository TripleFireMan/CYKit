//
//  CYForgotPasswordViewController.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYForgotPasswordViewController.h"
#import "XHToast.h"
#import "Masonry.h"
#import "CYKitDefines.h"

@interface CYForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *IDTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UITextField *pswAgainTF;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;

@end

@implementation CYForgotPasswordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
//    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"忘记密码"];
    self.view.backgroundColor = RGBColor(240, 240, 240);
    [self.firstView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CY_Height_NavBar + 10);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(55);
    }];
    
    self.pswTF.secureTextEntry = YES;
    self.pswAgainTF.secureTextEntry = YES;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)handleSubmitAction:(id)sender {
    
    if ([self p_checkIfEmpty:self.phoneTF]) {
        [XHToast showBottomWithText:@"请输入手机号"];
        return;
    }
    
    if ([self p_checkIfEmpty:self.IDTF]) {
        [XHToast showBottomWithText:@"请输入身份证号码"];
        return;
    }
    
    if ([self p_checkIfEmpty:self.pswTF]) {
        [XHToast showBottomWithText:@"请输入新密码"];
        return;
    }
    
    if ([self p_checkIfEmpty:self.pswAgainTF]) {
        [XHToast showBottomWithText:@"请输入确认密码"];
        return;
    }
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
}

- (BOOL) p_checkIfEmpty:(UITextField *)tf
{
    if ([tf text].length == 0) {
        return YES;
    }
    else{
        return NO;
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
