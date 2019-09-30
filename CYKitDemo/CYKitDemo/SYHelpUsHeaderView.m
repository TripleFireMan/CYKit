//
//  SYHelpUsHeaderView.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/7.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYHelpUsHeaderView.h"

@interface SYHelpUsHeaderView()
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (strong, nonatomic) IBOutlet UIView *lineView;

@end

@implementation SYHelpUsHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        self.imgView = [UIImageView new];
//        self.imgView.contentMode = UIViewContentModeScaleToFill;
//        [self addSubview:self.imgView];
//        self.titleLabel  = [UILabel new];
//        self.titleLabel.font = [UIFont boldSystemFontOfSize:32];
//        self.titleLabel.textColor = [UIColor whiteColor];
//        [self addSubview:self.titleLabel];
//        self.subTitleLabel = [UILabel new];
//        self.subTitleLabel.font = [UIFont boldSystemFontOfSize:18.f];
//        self.subTitleLabel.textColor = [UIColor whiteColor];
//        [self addSubview:self.subTitleLabel];
//        self.lineView = [UIView new];
//        self.lineView.backgroundColor = RGBColor(255, 255, 255);
//        [self addSubview:self.lineView];
//
//
//    }
//    return self;
//}
////
//- (void) layoutSubviews
//{
//    [super layoutSubviews];
//
//    [self.subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.offset(-44);
//        make.center.offset(0);
//    }];
//
//    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.subTitleLabel.mas_top).offset(-22);
//        make.width.offset(25);
//        make.height.offset(2);
//    }];
//
//    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.lineView.mas_top).offset(-15);
//        make.center.offset(0);
//    }];
//
//    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets(UIEdgeInsetsZero);
//    }];
//}


@end
