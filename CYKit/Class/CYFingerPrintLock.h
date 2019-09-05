//
//  CYFingerPrintLock.h
//  CYKit
//
//  Created by 成焱 on 2019/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef  NS_ENUM(NSInteger, CYUnlockSupportType){
    CYUnlockSupportType_None = 0,
    CYUnlockSupportType_TouchID,//指纹解锁
    CYUnlockSupportType_FaceID,//脸部识别
};
typedef NS_ENUM(NSInteger, CYUnlockResult) {
    CYUnlockResult_Failed = 0,
    CYUnlockResult_Success,
};

typedef void (^CYUnlockResultBlock)(CYUnlockResult, NSString *errMsg);
@interface CYFingerPrintLock : NSObject

@property (nonatomic, assign) CYUnlockSupportType supportType;

+ (CYFingerPrintLock *) shareInstance;
/// 检测支持的登录方式
+ (CYUnlockSupportType)checkUnlockSupportType;
/// 解锁
+ (void)unlockWithResultBlock:(CYUnlockResultBlock)block;
@end

NS_ASSUME_NONNULL_END
