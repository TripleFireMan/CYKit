//
//  CYPrivateView.m
//  CYKit
//
//  Created by chengyan on 2021/11/1.
//

#import "CYPrivateView.h"
#import "Masonry.h"
#import "CYKitDefines.h"
#import "CYH5ViewController.h"
#define THEME_COLOR [UIColor colorWithRed:195/255.f green:48/255.f blue:36/255.f alpha:1]

@interface CYPrivateView ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *maskview;
@property (nonatomic, strong) UIView *desContainer;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *desLbl;
@property (nonatomic, strong) UITextView *linkLbl;
@property (nonatomic, strong) UIButton *logoutBtn;
@property (nonatomic, strong) UIButton *agreenBtn;
@property (nonatomic, copy  ) void(^finish)(NSInteger);
@end
@implementation CYPrivateView

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.maskview];
        [self addSubview:self.container];
        [self.container addSubview:self.titleLbl];
        [self.container addSubview:self.desContainer];
        [self.desContainer addSubview:self.desLbl];
        [self.container addSubview:self.linkLbl];
        [self.container addSubview:self.logoutBtn];
        [self.container addSubview:self.agreenBtn];

        [self.maskview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];

        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(50);
            make.right.offset(-50);
            make.center.offset(0);
        }];

        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(15);
            make.centerX.offset(0);
        }];

        [self.desContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.right.offset(-15);
            make.top.equalTo(self.titleLbl.mas_bottom).offset(15);
        }];

        [self.desLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(5, 10, 40, 10));
        }];

        [self.linkLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.desContainer.mas_bottom).offset(15);
            make.left.offset(15);
            make.right.offset(-15);
        }];

        [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.equalTo(self.linkLbl.mas_bottom).offset(15);
            make.right.equalTo(self.mas_centerX).offset(-15);
            make.bottom.offset(-15);
            make.height.offset(38);
        }];

        [self.agreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.top.equalTo(self.linkLbl.mas_bottom).offset(15);
            make.left.equalTo(self.mas_centerX).offset(15);
            make.height.offset(38);
        }];
    }
    return self;
}
+ (instancetype) showOn:(UIView *)aView finishBlock:(void (^)(NSInteger))block{
    CYPrivateView *view = [[CYPrivateView alloc] initWithFrame:CGRectZero];
    view.finish = block;
    [aView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    return view;
}

- (UILabel *) titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.font = CYPingFangSCMedium(18);
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"隐私政策与协议";
    }
    return _titleLbl;
}

- (UIView *) container{
    if (!_container) {
        _container = [UIView new];
        _container.backgroundColor = [UIColor whiteColor];
        _container.layer.cornerRadius = 12.f;
        _container.layer.masksToBounds = YES;
    }
    return _container;
}

- (UIView *) maskview{
    if (!_maskview) {
        _maskview = [UIView new];
        _maskview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    return _maskview;
}

- (UITextView *) linkLbl{
    if (!_linkLbl) {
        _linkLbl = [UITextView new];
        _linkLbl.font = CYPingFangSCMedium(12);
        NSString *str = @"阅读完整版《用户协议》和《隐私政策》了解详尽条款内容";

        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];
        [att addAttributes:@{NSFontAttributeName:CYPingFangSCMedium(13),NSForegroundColorAttributeName:RGBColor(48, 48, 48)} range:[str rangeOfString:@"阅读完整版"]];
        [att addAttributes:@{NSFontAttributeName:CYPingFangSCMedium(13),NSForegroundColorAttributeName:RGBColor(48, 48, 48)} range:[str rangeOfString:@"和"]];
        [att addAttributes:@{NSFontAttributeName:CYPingFangSCMedium(13),NSForegroundColorAttributeName:RGBColor(48, 48, 48)} range:[str rangeOfString:@"了解详尽条款内容"]];
        [att addAttributes:@{NSLinkAttributeName:@"protocol://protocol",NSForegroundColorAttributeName:THEME_COLOR,NSFontAttributeName:CYPingFangSCMedium(13)} range:[str rangeOfString:@"《用户协议》"]];
        [att addAttributes:@{NSLinkAttributeName:@"private://private",NSForegroundColorAttributeName:THEME_COLOR,NSFontAttributeName:CYPingFangSCMedium(13)} range:[str rangeOfString:@"《隐私政策》"]];
        _linkLbl.userInteractionEnabled = YES;
        _linkLbl.attributedText = att;
        _linkLbl.linkTextAttributes = @{NSForegroundColorAttributeName:THEME_COLOR};
        _linkLbl.delegate = self;
        _linkLbl.editable = false;
        _linkLbl.scrollEnabled = false;
//        _linkLbl.selectable = false;

        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addGestureRecognizer:)];

        [_linkLbl  addGestureRecognizer:tapRecognizer];
    }
    return _linkLbl;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    if ([[URL scheme] isEqualToString:@"private"]) {
        self.finish ? self.finish(2) : nil;
        return NO;
    } else if ([[URL scheme] isEqualToString:@"protocol"]) {
        self.finish ? self.finish(3) : nil;
        return NO;
    }
    return YES;
}


- (UILabel *) desLbl{
    if (!_desLbl) {
        _desLbl = [UILabel new];
        _desLbl.font = CYPingFangSCRegular(12);
        _desLbl.numberOfLines = 0;
        _desLbl.textColor = RGBColor(126, 126, 126);
//        _desLbl.textColor = KHEXCOLOR(kMainColor);
        _desLbl.text = @"您在使用产品或服务前，请认真阅读并充分理解相关用户协议，当您点击同意相关条款，并开始使用产品服务，即您已经理解并同意该条款，该条款将构成对您具有法律约束力的文件，用户隐私主要包括以下内容：账号注册、用户个人隐私信息保护、用户发布内容规范、使用规则等";
    }
    return _desLbl;
}

- (BOOL) textViewShouldEndEditing:(UITextView *)textView{
    return NO;
}

- (UIView *) desContainer{
    if (!_desContainer) {
        _desContainer = [UIView new];
        _desContainer.layer.cornerRadius = 3;
        _desContainer.layer.masksToBounds = YES;
        _desContainer.backgroundColor = RGBColor(248, 249, 253);
    }
    return _desContainer;
}

- (UIButton *) logoutBtn{
//    @weakify(self);
    if (!_logoutBtn) {
        _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutBtn setTitle:@"不同意并退出" forState:UIControlStateNormal];
        _logoutBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _logoutBtn.backgroundColor = RGBColor(233, 233, 233);
        [_logoutBtn setTitleColor:RGBColor(158, 158, 158) forState:UIControlStateNormal];
        _logoutBtn.layer.cornerRadius = 19;
        _logoutBtn.layer.masksToBounds = YES;
        [_logoutBtn addTarget:self action:@selector(handleLogout:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutBtn;
}

- (UIButton *) agreenBtn{
//    @weakify(self);
    if (!_agreenBtn) {
        _agreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreenBtn setTitle:@"同意" forState:UIControlStateNormal];
        _agreenBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_agreenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _agreenBtn.layer.cornerRadius = 19;
        _agreenBtn.layer.masksToBounds = YES;
        _agreenBtn.backgroundColor = [UIColor colorWithRed:195/255.f green:48/255.f blue:36/255.f alpha:1];
        [_agreenBtn addTarget:self action:@selector(handleAgreen:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreenBtn;
}

- (void) handleAgreen: (id) sender{
    [self removeFromSuperview];
    self.finish ? self.finish(1) : nil;
}

- (void) handleLogout:(id) sender{
    exit(0);
}

@end

