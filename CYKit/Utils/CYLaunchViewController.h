//
//  SYLaunchViewController.h
//  SuoYi
//
//  Created by 成焱 on 2019/8/14.
//  Copyright © 2019 sy. All rights reserved.
//

#import <UIKit/UIKit.h>

// 发送启动图结束的通知
static NSString * _Nullable const k_DidFinishLaunchNotification = @"k_DidFinishLaunchNotification";

NS_ASSUME_NONNULL_BEGIN

@interface CYLaunchViewController : UIViewController

/// 倒计时,默认值3s倒计时
@property (nonatomic, assign) NSInteger countDown;
/// 过期时间，默认过期时间为3天
@property (nonatomic, assign) NSTimeInterval invaliedTime;
/// 倒计时文字颜色
@property (nonatomic, strong) UIColor *countDownTextColor;

/// 请求图片的入口
@property (nonatomic, copy) void(^CYFetchImageUrlBlock)(void);

/**
 下载图片
 */
- (void) downLoadImage:(NSString *)url;
/**
 结束启动页
 */
- (void) finishLaunch;
@end

NS_ASSUME_NONNULL_END
