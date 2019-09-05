//
//  CYWeiChatUser.h
//  SuoYi
//
//  Created by 成焱 on 2019/8/22.
//  Copyright © 2019 sy. All rights reserved.
//  微信授权登录对象

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define WX_BASE_URL             @"https://api.weixin.qq.com/sns"
#define WX_ACCESS_TOKEN         @"access_token"
#define WX_OPEN_ID              @"openid"
#define WX_UNIONID_ID           @"unionid"
#define WX_REFRESH_TOKEN        @"refresh_token"

#define WX_USER_city            @"city"
#define WX_USER_country         @"country"
#define WX_USER_headimgurl      @"headimgurl"
#define WX_USER_language        @"language"
#define WX_USER_nickname        @"nickname"
#define WX_USER_province        @"province"
#define WX_USER_sex             @"sex"

@interface CYWeiChatUser : NSObject

@property (nonatomic, strong, nullable) NSString *access_token;
@property (nonatomic, strong, nullable) NSString *openid;
@property (nonatomic, strong, nullable) NSString *unionid;
@property (nonatomic, strong, nullable) NSString *refresh_token;

@property (nonatomic, strong, nullable) NSString *city;
@property (nonatomic, strong, nullable) NSString *country;
@property (nonatomic, strong, nullable) NSString *headimgurl;
@property (nonatomic, strong, nullable) NSString *language;
@property (nonatomic, strong, nullable) NSString *nickname;
@property (nonatomic, strong, nullable) NSString *province;
@property (nonatomic, strong, nullable) NSNumber *sex;

+ (instancetype) shareInstance;
- (void) loginWithJsonObject:(id)json;
- (void) logout;
@end

NS_ASSUME_NONNULL_END
