//
//  UIResponder+CYAddition.m
//  AFNetworking
//
//  Created by 成焱 on 2020/1/7.
//

#import "UIResponder+CYAddition.h"
/// 打开H5页面
NSString *CYRouteEventOpenH5 = @"CYRouteEventOpenH5";
/// h5页面的urlkey
NSString *CYRouteEventOpenH5URLKey = @"CYRouteEventOpenH5URLKey";
/// 打电话
NSString *CYRouteEventMakePhoneCall = @"CYRouteEventMakePhoneCall";
/// 电话号码
NSString *CYRouteEventMakePhoneCallPhoneNumberKey = @"CYRouteEventMakePhoneCallPhoneNumberKey";

static UIResponder * currentFirstResponder = nil;
@implementation UIResponder (CYAddition)

+(id)currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
    return currentFirstResponder;
}

-(void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}

- (void) routeWithEventName:(NSString *)eventName userInfo:(nullable NSDictionary *)userInfo
{
    [[self nextResponder] routeWithEventName:eventName userInfo:userInfo];
}
@end
