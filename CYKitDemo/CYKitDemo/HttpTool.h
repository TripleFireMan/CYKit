//
//  HttpTool.h
//  StaffEHome
//
//  Created by webthink_mac on 2017/6/3.
//  Copyright © 2017年 webthink_mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#define k_SuoYiInterfaceSuccessCode     10002
// 正式环境or测试环境的开关，no：正式，yes：测试
#ifndef k_UserDefault_MacroSwitch
#define k_UserDefault_MacroSwitch       @"k_UserDefault_MacroSwitch"
#endif


extern BOOL SYDebugMacro(void);

extern NSString *SYHOST(void);

extern NSString *API_POST(NSString *url);
/*************INTERFACE************/
//图片上传接口
#define INTERFACE_UPLOAD_IMAGE  @"Controller/service/GetUploadBase64Info.ashx"
//上传二维码生成推广码的接口
#define INTERFACE_UPLOAD_CODE   @"Controller/service/GetPromoterUploadInfo.ashx"
//客户端2接口
#define INTERFACE_CLIENT_2      @"Controller/service/Client2.ashx?"
//支付接口
#define INTERFACE_PAY           @"Controller/Service/PayOrder.ashx?"
//埋点上报
#define ADD_POINT               @"Controller/service/MerchantClient.ashx?"

/*************ACTION************/
//存图片
#define ACTION_MODEFIER_AVATOR  @"StoreImgUrl"
//启动图
#define ACTION_LAUNCH_IMAGE     @"GetSplashScreen"
//登录
#define ACTION_LOGIN            @"ClientLoginNew"
//根据unionid获取注册信息
#define ACTION_REGIS_UNIONID    @"UnionToMerchant"
//根据商户id获取注册信息
#define ACTION_REGIS_MICHID     @"MchIDToMerchant"
//获取出租车金额信息
#define ACTION_QuickPay         @"QuickPay"
//获取出租车限额
#define ACTION_MoneyLimited     @"MoneyLimited"
//问题反馈
#define ACTION_FEED_BACK        @"Feedback"
//是否可以换吗
#define ACTION_CAN_CHANGE_CARD  @"CanChangeCard"
//换码
#define ACTION_CHANGE_CARD      @"ChangeMerchantCard"
//换码申请
#define ACTION_APPLY_RESET_CARD @"ApplyResetCard"
//消息
#define ACTION_NotificationListWithUrl @"NotificationListWithUrl"
//月度统计
#define ACTION_MONTH_ANALYTICS  @"MonthStatistics"
//首页广告轮播
#define ACTION_MerchantRollingDisplay @"MerchantRollingDisplay"
//获取订单个数
#define ACTION_QueryOrderCount  @"QueryOrderCount"
//上报经纬度
#define ACTION_LON_LAT          @"AddMerchantTrail"
//获取评价列表
#define ACTION_EvaluateList     @"EvaluateList"
//保存推广码的图片
#define ACTION_SAVE_RED_PACKAGE @"SaveRedPackageUrl"


@interface HttpTool : NSObject
/**
 POST请求（接收JSON格式数据）
 
 @param URLString  请求的URL
 @param parameters 请求的参数
 @param success    请求成功的回调
 @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters HUD:(BOOL)hud success:(void (^)(id responseObject)) success failure:(void(^)(NSError *error)) failure;

+ (void)GET:(NSString *)URLString parameters:(id)parameters HUD:(BOOL)hud success:(void (^)(id responseObject)) success failure:(void(^)(NSError *error)) failure;

+ (void)GETWithAction:(NSString *)action content:(NSDictionary *)content HUD:(BOOL)hud
 success:(void (^)(id responseObject)) success failure:(void(^)(NSError *error)) failure;

+ (void)GETWithAction:(NSString *)action content:(NSDictionary *)content HUD:(BOOL)hud
              successWithStatus:(void (^)(id data, NSInteger statusCode,NSString *msg)) success failure:(void(^)(NSError *error)) failure;

+ (void)UPLOAD:(NSString *)URLString parameters:(id)parameters HUD:(BOOL)hud success:(void (^)(id responseObject)) success failure:(void(^)(NSError *error)) failure;
+(void)ShowHUD; //显示挡板
+(void)HiddenHUD; //隐藏挡板
+(void)ShowHUDWithMsg:(NSString *)msg;

@end
