//
//  NSDate+CYExtend.m
//  CYKit
//
//  Created by 成焱 on 16/10/14.
//  Copyright © 2016年 chengyan. All rights reserved.
//

#import "NSDate+CYExtend.h"

@implementation NSDate (CYExtend)
- (NSDate *)cy_localDate
{
    NSTimeZone * timezoon = [NSTimeZone timeZoneWithName:@"GMT"];
    NSTimeZone * destimezoon = [NSTimeZone localTimeZone];
    NSTimeInterval offset = [timezoon secondsFromGMTForDate:self];
    NSTimeInterval nowoffset = [destimezoon secondsFromGMTForDate:self];
    NSTimeInterval interval = nowoffset - offset;
    NSDate *now = [NSDate dateWithTimeInterval:interval sinceDate:self];
    return now;
}
@end
