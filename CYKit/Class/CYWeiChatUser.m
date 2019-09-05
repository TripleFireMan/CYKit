//
//  CYWeiChatUser.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/22.
//  Copyright © 2019 sy. All rights reserved.
//

#import "CYWeiChatUser.h"
#import "NSObject+YYModel.h"
#define CYUSER_D  [NSUserDefaults standardUserDefaults]

@implementation CYWeiChatUser
+ (instancetype) shareInstance
{
    static CYWeiChatUser *User = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        User = [[CYWeiChatUser alloc] init];
    });
    return User;
}

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.access_token = [CYUSER_D objectForKey:WX_ACCESS_TOKEN];
        self.openid = [CYUSER_D objectForKey:WX_OPEN_ID];
        self.unionid = [CYUSER_D objectForKey:WX_UNIONID_ID];
        self.refresh_token = [CYUSER_D objectForKey:WX_REFRESH_TOKEN];
        self.city = [CYUSER_D objectForKey:WX_USER_city];
        self.nickname = [CYUSER_D objectForKey:WX_USER_nickname];
        self.country = [CYUSER_D objectForKey:WX_USER_country];
        self.headimgurl = [CYUSER_D objectForKey:WX_USER_headimgurl];
        self.sex = [CYUSER_D objectForKey:WX_USER_sex];
        self.language = [CYUSER_D objectForKey:WX_USER_language];
        self.province = [CYUSER_D objectForKey:WX_USER_province];
        
    }
    return self;
}

- (void) loginWithJsonObject:(id)json
{
    BOOL success =  [self modelSetWithJSON:json];
    if (success) {
        // 持久化到本地
        [CYUSER_D setObject:self.access_token forKey:WX_ACCESS_TOKEN];
        [CYUSER_D setObject:self.unionid forKey:WX_UNIONID_ID];
        [CYUSER_D setObject:self.openid forKey:WX_OPEN_ID];
        [CYUSER_D setObject:self.refresh_token forKey:WX_REFRESH_TOKEN];
        [CYUSER_D setObject:self.city forKey:WX_USER_city];
        [CYUSER_D setObject:self.nickname forKey:WX_USER_nickname];
        [CYUSER_D setObject:self.country forKey:WX_USER_country];
        [CYUSER_D setObject:self.province forKey:WX_USER_province];
        [CYUSER_D setObject:self.headimgurl forKey:WX_USER_headimgurl];
        [CYUSER_D setObject:self.sex forKey:WX_USER_sex];
        [CYUSER_D setObject:self.language forKey:WX_USER_language];
        [CYUSER_D synchronize];
    }
}

- (void) logout
{
    self.access_token = nil;
    self.unionid = nil;
    self.openid = nil;
    self.refresh_token = nil;
    self.city = nil;
    self.nickname = nil;
    self.country = nil;
    self.province = nil;
    self.headimgurl = nil;
    self.sex = nil;
    self.language = nil;
    [CYUSER_D setObject:nil forKey:WX_ACCESS_TOKEN];
    [CYUSER_D setObject:nil forKey:WX_UNIONID_ID];
    [CYUSER_D setObject:nil forKey:WX_OPEN_ID];
    [CYUSER_D setObject:nil forKey:WX_REFRESH_TOKEN];
    [CYUSER_D setObject:nil forKey:WX_USER_city];
    [CYUSER_D setObject:nil forKey:WX_USER_nickname];
    [CYUSER_D setObject:nil forKey:WX_USER_country];
    [CYUSER_D setObject:nil forKey:WX_USER_province];
    [CYUSER_D setObject:nil forKey:WX_USER_headimgurl];
    [CYUSER_D setObject:nil forKey:WX_USER_sex];
    [CYUSER_D setObject:nil forKey:WX_USER_language];
    [CYUSER_D synchronize];
}

@end
