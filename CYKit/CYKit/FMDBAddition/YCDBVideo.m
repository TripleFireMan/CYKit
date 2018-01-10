//
//  YCDBVideo.m
//  Youcai4iPhoneFramework
//
//  Created by chengyan on 2018/1/4.
//  Copyright © 2018年 Roy. All rights reserved.
//

#import "YCDBVideo.h"

@implementation YCDBVideo

YCDBMethods

+ (NSDictionary <NSString *,NSNumber *> *)attributeList
{
    return @{@"sqlid":@(YCDBAttributeType_NSInteger),
             @"version":@(YCDBAttributeType_NSString30),
             @"createDate":@(YCDBAttributeType_NSDate),
             @"updateDate":@(YCDBAttributeType_NSDate),
             @"videoId":@(YCDBAttributeType_NSString30),
             @"videoName":@(YCDBAttributeType_NSString30),
             };
}
@end



