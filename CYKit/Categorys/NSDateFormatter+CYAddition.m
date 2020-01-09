//
//  NSDateFormatter+CYAddition.m
//  SYJinZhongProject
//
//  Created by 成焱 on 2020/1/8.
//  Copyright © 2020 zmx. All rights reserved.
//

#import "NSDateFormatter+CYAddition.h"

@implementation NSDateFormatter (CYAddition)
+ (instancetype) cy_yy_MM_dd_heng
{
    static NSDateFormatter * cy_yy_MM_dd_heng = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cy_yy_MM_dd_heng = [[NSDateFormatter alloc] init];
        cy_yy_MM_dd_heng.dateFormat = @"yyyy-MM-dd";
        cy_yy_MM_dd_heng.timeZone = [NSTimeZone systemTimeZone];
    });
    return cy_yy_MM_dd_heng;
}

+ (instancetype) cy_yy_MM_dd_MaoHao
{
    static NSDateFormatter * cy_yy_MM_dd_heng = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cy_yy_MM_dd_heng = [[NSDateFormatter alloc] init];
        cy_yy_MM_dd_heng.dateFormat = @"yyyy:MM:dd";
        cy_yy_MM_dd_heng.timeZone = [NSTimeZone systemTimeZone];
    });
    return cy_yy_MM_dd_heng;
}

+ (instancetype) cy_yy_MM_dd_NianYueRi
{
    static NSDateFormatter * cy_yy_MM_dd_heng = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cy_yy_MM_dd_heng = [[NSDateFormatter alloc] init];
        cy_yy_MM_dd_heng.dateFormat = @"yyyy年MM月dd日";
        cy_yy_MM_dd_heng.timeZone = [NSTimeZone systemTimeZone];
    });
    return cy_yy_MM_dd_heng;
}

+ (instancetype) cy_yy_MM_dd_hh_mm_ss_heng
{
    static NSDateFormatter * cy_yy_MM_dd_heng = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cy_yy_MM_dd_heng = [[NSDateFormatter alloc] init];
        cy_yy_MM_dd_heng.dateFormat = @"yyyy-MM-dd hh-mm-ss";
        cy_yy_MM_dd_heng.timeZone = [NSTimeZone systemTimeZone];
    });
    return cy_yy_MM_dd_heng;
}

+ (instancetype) cy_yy_MM_dd_hh_mm_ss_MaoHao
{
    static NSDateFormatter * cy_yy_MM_dd_heng = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cy_yy_MM_dd_heng = [[NSDateFormatter alloc] init];
        cy_yy_MM_dd_heng.dateFormat = @"yyyy:MM:dd hh:mm:ss";
        cy_yy_MM_dd_heng.timeZone = [NSTimeZone systemTimeZone];
    });
    return cy_yy_MM_dd_heng;
}

+ (instancetype) cy_yy_MM_dd_hh_mm_ss_NianYueRi
{
    static NSDateFormatter * cy_yy_MM_dd_heng = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cy_yy_MM_dd_heng = [[NSDateFormatter alloc] init];
        cy_yy_MM_dd_heng.dateFormat = @"yyyy年MM月dd日 hh时mm分ss秒";
        cy_yy_MM_dd_heng.timeZone = [NSTimeZone systemTimeZone];
    });
    return cy_yy_MM_dd_heng;
}

@end
