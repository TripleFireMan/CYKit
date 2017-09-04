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
@end
