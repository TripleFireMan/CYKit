//
//  SYWeixinLoginViewController.h
//  SuoYi
//
//  Created by 成焱 on 2019/8/20.
//  Copyright © 2019 sy. All rights reserved.
//

#import "CYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,CYWexinLoginType) {
    CYWexinLoginType_Login,//登录
    CYWexinLoginType_Scan,//扫码
    CYWexinLoginType_NewUser,//新用户注册
    CYWexinLoginType_FogetPassword,//忘记密码
    CYWexinLoginType_LogoImage,//点击logo图
};

typedef void(^CYWexinLoginBlock)(CYWexinLoginType type);

@interface CYWeixinLoginViewController : CYBaseViewController

@property(nonatomic,retain) NSString * mytag;

@property (nonatomic, copy) CYWexinLoginBlock loginBlock;

@end

NS_ASSUME_NONNULL_END
