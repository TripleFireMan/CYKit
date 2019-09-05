//
//  CYFingerPrintLock.m
//  CYKit
//
//  Created by 成焱 on 2019/9/5.
//

#import "CYFingerPrintLock.h"
#import <LocalAuthentication/LocalAuthentication.h>

API_AVAILABLE(ios(8.0))
@interface CYFingerPrintLock ()
@property (nonatomic, strong) LAContext *context;
@end
@implementation CYFingerPrintLock
+ (instancetype) shareInstance
{
    static CYFingerPrintLock *lock = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = [CYFingerPrintLock new];
    });
    return lock;
}

- (instancetype) init
{
    if (self = [super init]) {
        if (__builtin_available(iOS 8.0, *)) {
            self.context = [[LAContext alloc] init];
        } else {
            
        }
    }
    return self;
}

+ (CYUnlockSupportType) checkUnlockSupportType
{
    CYUnlockSupportType supportType = CYUnlockSupportType_None;
    
    if (@available(iOS 8.0, *)) {
        LAContext *context = [[LAContext alloc] init];
        NSError *error = nil;
        BOOL isCanEvaluatePolicy = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        if (error) {
            NSLog(@"检测人脸识别失败，错误：%@",error.localizedDescription);
        }
        else{
            if (isCanEvaluatePolicy) {
                if (@available(iOS 11.0, *)) {
                    switch (context.biometryType) {
                        case LABiometryTypeNone:
                            {
                                
                            }
                            break;
                        case LABiometryTypeFaceID:
                        {
                            supportType = CYUnlockSupportType_FaceID;
                        }
                            break;
                        case LABiometryTypeTouchID:
                        {
                            supportType = CYUnlockSupportType_TouchID;
                        }
                            break;
                        default:
                            break;
                    }
                } else {
                    supportType = CYUnlockSupportType_TouchID;
                }
            }
        }
    } else {
        
    }
    
    [self shareInstance].supportType = supportType;
    return supportType;
}

+ (void) unlockWithResultBlock:(CYUnlockResultBlock)block
{
    
    if (@available(iOS 8.0, *)) {
        LAContext *context = [self shareInstance].context;
        context.localizedFallbackTitle = @"输入密码";
        LAPolicy policyType = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
        if (@available(iOS 9.0, *)) {
            policyType = LAPolicyDeviceOwnerAuthentication;
        }
        NSError *error = nil;
        if ([context canEvaluatePolicy:policyType error:&error]) {
            NSString *string = nil;
            switch ([[self shareInstance] supportType]) {
                case CYUnlockSupportType_FaceID:
                {
                    string = @"请将脸部对准摄像头";
                }
                    
                    break;
                case CYUnlockSupportType_TouchID:
                {
                    string = @"请将手指放到TouchID上";
                }
                    break;
                default:
                    break;
            }
            [context evaluatePolicy:policyType localizedReason:@"输入密码" reply:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block?block(CYUnlockResult_Success,@"成功"):nil;
                    });
                }
                else{
                    if (error) {
                        block?block(CYUnlockResult_Failed,error.localizedDescription):nil;
                    }
                    else{
                        block?block(CYUnlockResult_Failed,@""):nil;
                    }
                }
            }];
        }
        else{
            block?block(CYUnlockResult_Failed,@""):nil;
        }
    }
    else{
        block?block(CYUnlockResult_Failed,@""):nil;
    }
}
@end
