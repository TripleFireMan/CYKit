//
//  SYDebugModel.h
//  SuoYi
//
//  Created by 成焱 on 2019/8/26.
//  Copyright © 2019 sy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const k_UserDefauleUseFaceIDKey = @"k_UserDefauleUseFaceIDKey";

typedef NS_ENUM(NSInteger,SYDebugCellType){
    /// 接口控制
    SYDebugCell_InterfaceChangeType,
    /// 清楚用户缓存并退出登录
    SYDebugCell_ClearUserInfoAndLogout,
    /// 人脸识别和指纹识别开关
    SYDebugCell_OpenFaceIDOrTouchID,
};

@interface SYDebugModel : NSObject

@property (nonatomic, assign) NSInteger SYDebugType;

- (void) save;

@end

@interface SYInterfaceDebugModel : SYDebugModel
@property (nonatomic, copy) NSString *debugHost;
@property (nonatomic, copy) NSString *releaseHost;
@property (nonatomic, assign) BOOL isDebug;



@end

@interface SYDebugFaceIDTouchIDModel : SYDebugModel

@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, strong) NSNumber *isOpen;

@end

@interface SYDebugClearUserInfoModel : SYDebugModel
@property (nonatomic, copy) NSString *title;
@end


NS_ASSUME_NONNULL_END
