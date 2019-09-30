//
//  SYAboutUsHeaderView.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/7.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYAboutUsHeaderView.h"
@interface SYAboutUsHeaderView ()
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *logoImageView;
@end
@implementation SYAboutUsHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) awakeFromNib
{
    [super awakeFromNib];
    self.versionLabel.text = [NSString stringWithFormat:@"版本: V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.topImageView = [UIImageView new];
        self.topImageView.image = [UIImage imageNamed:@"sy_about_us_header"];
        [self addSubview:self.topImageView];
        [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
        
        self.logoImageView = [UIImageView new];
        self.logoImageView.image = [UIImage imageNamed:@"sy_about_us_icon"];
        [self addSubview:self.logoImageView];
        [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(60);
            make.centerX.offset(0);
            make.width.height.offset(88.f);
        }];
        
        self.versionLabel = [UILabel new];
        self.versionLabel.text =[NSString stringWithFormat:@"版本: V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        self.versionLabel.font = [UIFont systemFontOfSize:16];
        self.versionLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.versionLabel];
        [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logoImageView.mas_bottom).offset(14);
            make.centerX.offset(0);
        }];
        
    }
    return self;
}


@end
