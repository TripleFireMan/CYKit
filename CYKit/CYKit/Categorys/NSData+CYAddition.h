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
@end
