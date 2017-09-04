//
//  NSData+CYAddition.h
//  Pods
//
//  Created by chengyan on 2017/9/4.
//
//

#import <Foundation/Foundation.h>

@interface NSData (CYAddition)
///-------------------------------------------
/// @name hash
///-------------------------------------------

/**
 get a lowercase NSString for md2 hash

 @return a lowercase NSString for md2 hash
 */
- (nullable NSString *)cy_md2String;

/**
 get a NSData for md2 hash

 @return a NSData for md2 hash
 */
- (nullable NSData *)cy_md2Data;

/**
 get a lowercase NSString for md4 hash

 @return a lowercase NSString for md4 hash
 */
- (nullable NSString *)cy_md4String;

/**
 get a NSData for md4 data

 @return a NSData for md4 data
 */
- (nullable NSData *)cy_md4Data;

/**
 get a lowercase NSString for md5 hash

 @return a lowercase NSString for md5 hash
 */
- (nullable NSString *)cy_md5String;

/**
 get a NSData for md5 hash

 @return a NSData for md5 hash
 */
- (nullable NSData *)cy_md5Data;

/**
 a lowercase NSString for sha1 hash

 @return a lowercase NSString for sha1 hash
 */
- (nullable NSString *)cy_sha1String;

/**
 a NSData for sha1 hash

 @return a NSData for sha1 hash
 */
- (nullable NSData *)cy_sha1Data;

/**
 a lowercase NSString for sha224 hash

 @return a lowercase NSString for sha224 hash
 */
- (nullable NSString *)cy_sha224String;

/**
 a NSData for sha224 hash

 @return a NSData for sha224 hash
 */
- (nullable NSData *)cy_sha224Data;

/**
 a lowercase NSString for sha256 hash
 
 @return a lowercase NSString for sha256 hash
 */
- (nullable NSString *)cy_sha256String;

/**
 a NSData for sha256 hash
 
 @return a NSData for sha256 hash
 */
- (nullable NSData *)cy_sha256Data;

/**
 a lowercase NSString for sha384 hash
 
 @return a lowercase NSString for sha384 hash
 */
- (nullable NSString *)cy_sha384String;

/**
 a NSData for sha384 hash
 
 @return a NSData for sha384 hash
 */
- (nullable NSData *)cy_sha384Data;

/**
 a lowercase NSString for sha512 hash
 
 @return a lowercase NSString for sha512 hash
 */
- (nullable NSString *)cy_sha512String;

/**
 a NSData for sha512 hash
 
 @return a NSData for sha512 hash
 */
- (nullable NSData *)cy_sha512Data;

/**
 a lowercase NSString for hmac using algorithm MD5 with key.

 @param key the hmac key
 @return a lowercase NSString for hmac using algorithm MD5 with key.
 */
- (nullable NSString *)cy_hmacMD5StringWithKey:(nullable NSString *)key;

/**
 a NSData for hmac using algorithm MD5 with key

 @param key the hmac key
 @return a NSData for hmac using algorithm MD5 with key
 */
- (nullable NSData *)cy_hmacMD5DataWithKey:(nullable NSData *)key;

/**
 a lowercase NSString for hmac using algorithm SHA1 with key.

 @param key the hmac key
 @return a lowercase NSString for hmac using algorithm SHA1 with key.
 */
- (nullable NSString *)cy_hmacSha1StringWithKey:(nullable NSString *)key;

/**
 a NSData for hmac using algorithm SHA1 with key

 @param key the hmac key
 @return a NSData for hmac using algorithm SHA1 with key
 */
- (nullable NSData *)cy_hmacSha1DataWithKey:(nullable NSData *)key;

/**
 a lowercase NSString for crc32 hash

 @return a lowercase NSString for crc32 hash
 */
- (nullable NSString *)cy_crc32String;

/**
 crc32 hash

 @return crc32 hash
 */
- (uint32_t)cy_crc32Data;


///-------------------------------------------
/// @name encrypt&decrypt
///-------------------------------------------

/**
 an encrypt NSData using AES.

 @param key a key length of 16,24 or 32 (128,192 or 256bits).
 @param iv an initialization vector length of 16(128bits),pass nil when you don't want to use iv.
 @return An NSData encrypted,or nil if an error occurs.
 */
- (nullable NSData *)cy_aes256EncryptWithKey:(nullable NSData *)key iv:(nullable NSData *)iv;

/**
 an decrypt NSData using AES

 @param key a key length of 16,24 or 32 (128,192 or 256bits).
 @param iv iv an initialization vector length of 16(128bits),pass nil when you don't want to use iv.
 @return an NSData decrypted, or nil if an error occurs.
 */
- (nullable NSData *)cy_aes256DecryptWithKey:(nullable NSData *)key iv:(nullable NSData *)iv;

///-------------------------------------------
/// @name encode&decode
///-------------------------------------------

/**
 a lowercase NSString for base64
 
 @return a lower NSString for base64
 */
- (nullable NSString *)cy_base64String;

/**
 a NSData from base64 encoded string

 @param base64EncodedString the encoded string
 @return a NSData from base64 encoded string
 */
+ (nullable NSData *)cy_dataWithBase64EncodeedString:(nullable NSString *)base64EncodedString;
@end
