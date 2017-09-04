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

- (nullable NSString *)cy_sha1String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding]cy_sha1String];
}

- (nullable NSString *)cy_sha224String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding]cy_sha224String];
}

- (nullable NSString *)cy_sha256String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding]cy_sha256String];
}

- (nullable NSString *)cy_sha384String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding]cy_sha384String];
}

- (nullable NSString *)cy_sha512String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding]cy_sha512String];
}

- (nullable NSString *)cy_hmacMD5StringWithKey:(NSString *)key
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding]cy_hmacMD5StringWithKey:key];
}

- (nullable NSString *)cy_hmacSHA1StringWithKey:(NSString *)key
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding]cy_hmacSha1StringWithKey:key];
}

- (nullable NSString *)cy_crc32String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding]cy_crc32String];
}
@end
