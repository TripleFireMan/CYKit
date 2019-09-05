//
//  CYEvaluate.h
//  CYKit
//
//  Created by 成焱 on 2019/9/5.
//  验证类，验证手机号、身份证、邮箱、密码等

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYEvaluate : NSObject

/// 验证手机号
+ (BOOL) validateMobile:(NSString *)mobile;
/// 邮箱
+ (BOOL) validateEmail:(NSString *)email;
/// 车牌
+ (BOOL) validateCarNo:(NSString *)carNo;
/// 用户名
+ (BOOL) validateUserName:(NSString *)name;
/// 密码
+ (BOOL) validatePassword:(NSString *)passWord;
/// 身份证
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
/// 银行卡
+ (BOOL) validateBankCardNumber:(NSString *)cardNum;
@end

NS_ASSUME_NONNULL_END
