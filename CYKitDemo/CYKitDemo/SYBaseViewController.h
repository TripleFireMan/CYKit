//
//  ViewController.h
//  SuoYi
//
//  Created by sy on 2019/7/24.
//  Copyright © 2019年 sy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYBaseViewController : UIViewController

/// 是否展示返回按钮，默认为YES，如果不需要请关闭
@property (nonatomic, assign) BOOL shouldShowBackBtn;
/// 是否展示头视图
@property (nonatomic, assign) BOOL shouldShowHeader;
/// 是否展示顶部头图
@property (nonatomic, assign) BOOL shouldShowHeaderImage;
/// 头部视图
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;

- (void) setupSubviews;
- (void) addConstrains;

@end


