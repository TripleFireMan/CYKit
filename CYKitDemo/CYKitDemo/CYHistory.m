//
//  CYHistory.m
//  CYKitDemo
//
//  Created by chengyan on 2018/1/9.
//  Copyright © 2018年 cheng.yan. All rights reserved.
//

#import "CYHistory.h"

@implementation CYHistory
YCDBMethods
+ (NSDictionary <NSString *,NSNumber *> *)attributeList
{
    return @{@"version":@(YCDBAttributeType_NSString30),
             @"sqlid":@(YCDBAttributeType_NSInteger),
             @"updateDate":@(YCDBAttributeType_NSDate),
             @"createDate":@(YCDBAttributeType_NSDate),
             @"name":@(YCDBAttributeType_NSString30),
             @"desc":@(YCDBAttributeType_NSString30),
             };
}
@end
