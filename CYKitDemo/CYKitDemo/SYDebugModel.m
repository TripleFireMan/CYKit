//
//  SYDebugModel.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/26.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYDebugModel.h"
#define k_SYMacroInterFaceKey @"k_SYMacroInterFaceKey"
@implementation SYDebugModel
- (void) save
{
    
}
@end

@implementation SYInterfaceDebugModel
@synthesize isDebug = _isDebug;

- (instancetype) init
{
    self = [super init];
    if (self) {
        NSNumber *isDebug = [[NSUserDefaults standardUserDefaults] objectForKey:k_UserDefault_MacroSwitch];
        if (isDebug) {
            self.isDebug = [[[NSUserDefaults standardUserDefaults] objectForKey:k_UserDefault_MacroSwitch] boolValue];
        }
        else{
            self.isDebug = SYDebugMacro();
        }
        self.SYDebugType = SYDebugCell_InterfaceChangeType;
    }
    return self;
}
- (NSString *) debugHost
{
    if (_debugHost) {
        return _debugHost;
    }
    return @"https://paytest.sooyie.cn/";
}

- (NSString *) releaseHost
{
    if (_releaseHost) {
        return _releaseHost;
    }
    return @"https://pay.sooyie.cn/";
}

- (void) setIsDebug:(BOOL)isDebug
{
    _isDebug = isDebug;
}

- (BOOL) isDebug
{
    return _isDebug;
}

- (void) save
{
    [[NSUserDefaults standardUserDefaults] setObject:@(self.isDebug) forKey:k_UserDefault_MacroSwitch];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

@implementation SYDebugFaceIDTouchIDModel

- (id) init
{
    self = [super init];
    if (self) {
        self.isOpen = [[NSUserDefaults standardUserDefaults] objectForKey:k_UserDefauleUseFaceIDKey];
        self.SYDebugType = SYDebugCell_OpenFaceIDOrTouchID;
    }
    return self;
}

- (NSString *) title{
    if (_title) {
        return _title;
    }
    return @"是否使用FaceID或TouchID进行登录";
}

- (void) save
{
    [[NSUserDefaults standardUserDefaults] setObject:self.isOpen forKey:k_UserDefauleUseFaceIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end

@implementation SYDebugClearUserInfoModel
- (NSString *) title{
    if (_title) {
        return _title;
    }
    return @"清除所有用户缓存，并退出登录";
}

@end
