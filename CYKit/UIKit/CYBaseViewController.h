//
//  CYBaseViewController.h
//  AFNetworking
//
//  Created by 成焱 on 2019/8/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYBaseViewController : UIViewController

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

@end

NS_ASSUME_NONNULL_END
