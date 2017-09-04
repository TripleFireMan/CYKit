//
//  NSString+CYAddition.m
//  Pods
//
//  Created by chengyan on 2017/9/4.
//
//

#import "NSString+CYAddition.h"
#import "NSData+CYAddition.h"
@implementation NSString (CYAddition)

- (nullable NSString *)cy_md2String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding]cy_md2String];
}

- (nullable NSString *)cy_md4String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding]cy_md4String];
}

- (nullable NSString *)cy_md5String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding]cy_md5String];
}
@end
