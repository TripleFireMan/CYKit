//
//  NSDate+CYExtend.h
//  CYKit
//
//  Created by 成焱 on 16/10/14.
//  Copyright © 2016年 chengyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CYExtend)

///将UTC/GTM时间转换为当地时间
- (NSDate *)cy_localDate;

@end
