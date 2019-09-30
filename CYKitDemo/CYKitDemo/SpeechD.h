//
//  SpeechD.h
//  NotificationService
//
//  Created by sy on 2019/7/29.
//  Copyright © 2019年 sy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpeechD : NSObject
+ (void)playPushNotifationVideo:(NSString *)str Type:(NSString*)type;
+ (NSArray *)caculateNumber:(NSString *)primary Type:(NSString *)type;
+ (void)hecheng:(NSArray *)fileNameArray;
/// 成为音频并返回音频文件地址
+ (void)hechengPushMoney:(NSString *)money
                    type:(NSString *)type
                complete:(void(^)(NSURL *fileUrl))complete;
@end

NS_ASSUME_NONNULL_END
