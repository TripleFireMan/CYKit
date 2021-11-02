//
//  CYPrivateView.h
//  CYKit
//
//  Created by chengyan on 2021/11/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYPrivateView : UIView
/// 1 - 继续 2 -  隐私协议 3- 用户协议
+ (instancetype) showOn:(UIView *)aView finishBlock:(void(^)(NSInteger idx))block;
@end

NS_ASSUME_NONNULL_END
