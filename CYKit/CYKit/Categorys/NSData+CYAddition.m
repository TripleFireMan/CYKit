//
//  NSData+CYAddition.m
//  Pods
//
//  Created by chengyan on 2017/9/4.
//
//

#import "NSData+CYAddition.h"
#import <CommonCrypto/CommonCrypto.h>
#import <zlib.h>

@implementation NSData (CYAddition)

- (nullable NSString *)cy_md2String
{
    unsigned char result[CC_MD2_DIGEST_LENGTH];
    CC_MD2(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],
            result[6],result[7],result[8]
            ,result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
}

- (nullable NSData *)cy_md2Data
{
    unsigned char result[CC_MD2_DIGEST_LENGTH];
    CC_MD2(self.bytes,(CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD2_DIGEST_LENGTH];
}

- (nullable NSString *)cy_md4String
{
    unsigned char result[CC_MD4_DIGEST_LENGTH];
    CC_MD4(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
}

- (nullable NSData *)cy_md4Data
{
    unsigned char result[CC_MD4_DIGEST_LENGTH];
    CC_MD4(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD4_DIGEST_LENGTH];
}

- (nullable NSString *)cy_md5String
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
}

- (nullable NSData *)cy_md5Data
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

- (nullable NSString *)cy_sha1String
{
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x",result[i]];
    }
    return hash;
}

- (nullable NSData *)cy_sha1Data
{
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA1_DIGEST_LENGTH];
}

- (nullable NSString *)cy_sha224String
{
    unsigned char result[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x",result[i]];
    }
    return hash;
}

- (nullable NSData *)cy_sha224Data
{
    unsigned char result[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA224_DIGEST_LENGTH];
}

- (nullable NSString *)cy_sha256String
{
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x",result[i]];
    }
    return hash;
}

- (nullable NSData *)cy_sha256Data
{
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA256_DIGEST_LENGTH];
}

- (nullable NSString *)cy_sha384String
{
    unsigned char result[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x",result[i]];
    }
    return hash;
}

- (nullable NSData *)cy_sha384Data
{
    unsigned char result[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA384_DIGEST_LENGTH];
}

- (nullable NSString *)cy_sha512String
{
    unsigned char result[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x",result[i]];
    }
    return hash;
}

- (nullable NSData *)cy_sha512Data
{
    unsigned char result[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA512_DIGEST_LENGTH];
}

- (nullable NSString *)cy_hmacStringUsingAlgorithm:(CCHmacAlgorithm)alg key:(NSString *)key
{
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5:size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1:size = CC_SHA1_DIGEST_LENGTH;break;
        default: return nil;
    }
    unsigned char result[size];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(alg, cKey, strlen(cKey), self.bytes, self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:size * 2];
    for (int i = 0; i < size; i++) {
        [hash appendFormat:@"%02x",result[i]];
    }
    return hash;
}

- (nullable NSData *)cy_hmacDataUsingAlgorithm:(CCHmacAlgorithm)alg key:(NSData *)key
{
    size_t size;
    switch(alg){
        case kCCHmacAlgMD5:size = CC_MD5_DIGEST_LENGTH;break;
        case kCCHmacAlgSHA1:size = CC_SHA1_DIGEST_LENGTH;break;
        default:return nil;
    }
    
    unsigned char result[size];
    CCHmac(alg, key.bytes, key.length, self.bytes, self.length, result);
    return [NSData dataWithBytes:result length:size];
}

- (nullable NSString *)cy_hmacSha1StringWithKey:(NSString *)key
{
    return [self cy_hmacStringUsingAlgorithm:kCCHmacAlgSHA1 key:key];
}

- (nullable NSData *)cy_hmacSha1DataWithKey:(NSData *)key
{
    return [self cy_hmacDataUsingAlgorithm:kCCHmacAlgSHA1 key:key];
}

- (nullable NSString *)cy_hmacMD5StringWithKey:(NSString *)key
{
    return [self cy_hmacStringUsingAlgorithm:kCCHmacAlgMD5 key:key];
}

- (nullable NSData *)cy_hmacMD5DataWithKey:(NSData *)key
{
    return [self cy_hmacDataUsingAlgorithm:kCCHmacAlgMD5 key:key];
}

- (nullable NSString *)cy_crc32String
{
    uLong result = crc32(0, self.bytes, (uInt)self.length);
    return [NSString stringWithFormat:@"%08x",(uint32_t)result];
}

- (uint32_t)cy_crc32Data
{
    uLong result = crc32(0, self.bytes, (uInt)self.length);
    return (uint32_t)result;
}
@end
