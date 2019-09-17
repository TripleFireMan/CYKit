//
//  CYNetworkCommand.h
//  CYKit
//
//  Created by 成焱 on 2019/9/17.
//  基于RACCommand对网络请求的封装

#import <Foundation/Foundation.h>

@class RACCommand;

typedef NS_ENUM(NSInteger, CYNetworkStatus){
    /// 请求开始
    CYNetworkStatus_Begin,
    /// 请求结束
    CYNetworkStatus_End,
    /// 请求错误
    CYNetworkStatus_Error,
};

FOUNDATION_EXTERN  NSString  * _Nonnull  k_CY_URL;
FOUNDATION_EXTERN  NSString  * _Nonnull  k_CY_PARAMS;

NS_ASSUME_NONNULL_BEGIN

@interface CYNetworkCommand : NSObject
/// get请求
@property (nonatomic, strong) RACCommand *getCommand;
/// post请求
@property (nonatomic, strong) RACCommand *postCommand;
/// 请求状态
@property (nonatomic, assign) CYNetworkStatus status;
/// 错误
@property (nonatomic, strong, nullable) NSError *error;
/// 请求结果
@property (nonatomic, strong, nullable) id data;
/// 请求地址
@property (nonatomic, strong, readonly) NSString *url;
/// 请求参数
@property (nonatomic, strong, readonly) NSDictionary *params;

@end

NS_ASSUME_NONNULL_END
