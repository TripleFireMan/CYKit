//
//  CYUser.h
//  AFNetworking
//
//  Created by 成焱 on 2020/1/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYUser : NSObject

+ (instancetype) shareInstance;
/// 退出登录
- (void) logout;
/// 保存
- (void) save;
@end

NS_ASSUME_NONNULL_END
