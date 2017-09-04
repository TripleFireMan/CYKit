//
//  NSString+CYAddition.h
//  Pods
//
//  Created by chengyan on 2017/9/4.
//
//

#import <Foundation/Foundation.h>

@interface NSString (CYAddition)

///-------------------------------------------
/// @name hash
///-------------------------------------------

/**
 get a lowercase NSString for md2 hash
 
 @return a lowercase NSString for md2 hash
 */
- (nullable NSString *)cy_md2String;

/**
 get a lowercase NSString for md4 hash

 @return a lowercase NSString for md2 hash
 */
- (nullable NSString *)cy_md4String;

/**
 get a lowercase NSString for md5 hash

 @return a lowercase NSString for md5 hasgh
 */
- (nullable NSString *)cy_md5String;

/**
 a lowercase NSString for sha1 hash

 @return a lowercase NSString for sha1 hash
 */
- (nullable NSString *)cy_sha1String;

/**
 a lowercase NSString for sha224 hash

 @return a lowercase NSString for sha224 hash
 */
- (nullable NSString *)cy_sha224String;

/**
 a lowercase NSString for sha256 hash

 @return a lowercase NSString for sha256 hash
 */
- (nullable NSString *)cy_sha256String;

/**
 a lowercase NSString for sha384 hash

 @return a lowercase NSString for sha384 hash
 */
- (nullable NSString *)cy_sha384String;

/**
 a lowercase NSString for sha512 hash
 
 @return a lowercase NSString for sha512 hash
 */
- (nullable NSString *)cy_sha512String;

/**
 hmac(Hash-based Message Authentication Code),a lowercase NSString for hmac using algorthm md5 with key

 @param key the hmac key
 @return a lowercase NSString for hmac using algorthm md5 with key
 */
- (nullable NSString *)cy_hmacMD5StringWithKey:(NSString *_Nullable)key;

/**
 hmac(Hash-based Message Authentication Code),a lowercase NSString for hmac using algorthm sha1 with key
 
 @param key the hmac key
 @return a lowercase NSString for hmac using algorthm sha1 with key
 */
- (nullable NSString *)cy_hmacSHA1StringWithKey:(NSString *_Nullable)key;

/**
 a lowercase NSString for crc32 hash

 @return a lowercase NSString for crc32 hash
 */
- (nullable NSString *)cy_crc32String;
@end
