//
//  NSDateFormatter+CYAddition.h
//  SYJinZhongProject
//
//  Created by 成焱 on 2020/1/8.
//  Copyright © 2020 zmx. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (CYAddition)

/// eg:2020-01-07
+ (instancetype) cy_yy_MM_dd_heng;
/// eg:2020:01:07
+ (instancetype) cy_yy_MM_dd_MaoHao;
/// eg:2020年01月07日
+ (instancetype) cy_yy_MM_dd_NianYueRi;

/// eg:2020-01-07 20-01-22
+ (instancetype) cy_yy_MM_dd_hh_mm_ss_heng;
/// eg:2020:01:07 20:01:22
+ (instancetype) cy_yy_MM_dd_hh_mm_ss_MaoHao;
/// eg:2020年01月07日 20时01分22秒
+ (instancetype) cy_yy_MM_dd_hh_mm_ss_NianYueRi;

@end

NS_ASSUME_NONNULL_END
