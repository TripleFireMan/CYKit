//
//  changePasswordVC.m
//  SuoYi
//
//  Created by CY on 2019/7/31.
//  Copyright © 2019年 CY. All rights reserved.
//

#import "CYChangePasswordViewController.h"
#import "CYForgotPasswordViewController.h"
#import "XHToast.h"
#import "Masonry.h"
#import "CYKitDefines.h"
@interface CYChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *sourePswTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UITextField *pswAgainTF;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation CYChangePasswordViewController

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}
- (IBAction)handleSubmitAction:(id)sender {
    
    
    if ([self p_checkIfEmpty:self.sourePswTF]) {
        [XHToast showBottomWithText:@"请输入原密码"];
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

- (IBAction)handleForgetPsw:(id)sender {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CYKit" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    CYForgotPasswordViewController *forgetPsw = [[CYForgotPasswordViewController alloc] initWithNibName:@"CYForgotPasswordViewController" bundle:bundle];
    [self.navigationController pushViewController:forgetPsw animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(240, 240, 240);
    self.title = @"修改密码";
    
        UIButton *left = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [left setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [left addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
        [left setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:left];
    // Do any additional setup after loading the view.
    self.pswTF.secureTextEntry = YES;
    self.pswAgainTF.secureTextEntry = YES;
    self.sourePswTF.secureTextEntry = YES;
    [self.firstView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CY_Height_NavBar + 10);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(55);
    }];
}
- (void)backbtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL) p_checkIfEmpty:(UITextField *)tf
{
    if ([tf text].length == 0) {
        return YES;
    }
    else{
        return NO;
    }
}

@end
