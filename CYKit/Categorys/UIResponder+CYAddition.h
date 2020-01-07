//
//  UIResponder+CYAddition.h
//  AFNetworking
//
//  Created by 成焱 on 2020/1/7.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 打开H5页面
UIKIT_EXTERN NSString *CYRouteEventOpenH5;
/// h5页面的urlkey
UIKIT_EXTERN NSString *CYRouteEventOpenH5URLKey;
/// 打电话
UIKIT_EXTERN NSString *CYRouteEventMakePhoneCall;
/// 电话号码
UIKIT_EXTERN NSString *CYRouteEventMakePhoneCallPhoneNumberKey;

@protocol CYRouterProtocol <NSObject>
@optional
- (void) routeWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
@end


@interface UIResponder (CYAddition)
- (void) routeWithEventName:(NSString *)eventName userInfo:(nullable NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
