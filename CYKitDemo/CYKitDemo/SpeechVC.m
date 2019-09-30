//
//  SpeechVC.m
//  SuoYi
//
//  Created by sy on 2019/7/25.
//  Copyright © 2019年 sy. All rights reserved.
//

#import "SpeechVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SpeechD.h"
@interface SpeechVC ()
@property(nonatomic,retain) UITextField * accountTextField;
@property(nonatomic,retain) UIButton * loginBtn;
@end

@implementation SpeechVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
    // Do any additional setup after loading the view.
}
- (void)creatUI{
    
    self.accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(80, 150, 150, 30)];
    self.accountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.accountTextField.placeholder = @"请输入金额";
    self.accountTextField.tag = 131;
    self.accountTextField.backgroundColor = [UIColor yellowColor];
    self.accountTextField.tintColor = [UIColor lightGrayColor];
    [self.view addSubview:self.accountTextField];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.backgroundColor = [UIColor redColor];
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.frame = CGRectMake(80, 250, 150, 40);
    [self.loginBtn setTitle:@"播放金额" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.loginBtn addTarget:self action:@selector(LoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
}

- (void)LoginBtnClick{
    NSString *str = self.accountTextField.text;
    dispatch_queue_t queue = dispatch_queue_create("readItNow", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSArray *ResultArr = [SpeechD caculateNumber:str Type:@"微信到账"];
    
//        NSArray  *ResultArr  = [[self caculateNumber:str] mutableCopy];
//        [self hecheng:ResultArr];
        [SpeechD hecheng:ResultArr];
    });
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
