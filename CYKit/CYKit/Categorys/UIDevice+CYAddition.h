//
//  UIDevice+CYAddition.h
//  Pods
//
//  Created by chengyan on 2017/8/31.
//
//

#import <UIKit/UIKit.h>

@interface UIDevice (CYAddition)

///-------------------------------------------
/// @name device infos
///-------------------------------------------

/**
 machine name ,eg. iPhone2,1 => iPhone3GS iPhone3,1 => iPhone4

 @return machine name, not iPhone 4,iPhone 3GS, otherwise iPhone2,1 iPhone3,1
 */
+ (NSString *)cy_deviceName;

/**
 ip address, should connect with wifi or 3g,4g net

 @return device current ip address
 */
+ (NSString *)cy_ipAddress;

/**
 mac address, ios 10 or later may be nil

 @return mac address
 */
+ (NSString *)cy_macAddress;

/**
 carrier name ,format => carrier name + country code

 @return carrier name
 */
+ (NSString *)cy_carrier;

///-------------------------------------------
/// @name device system files
///-------------------------------------------

/**
 the file system,device total usage space

 @return total device space size
 */
+ (NSNumber *)cy_totalDeviceSize;

/**
 the file system,device free usage space

 @return free device space size
 */
+ (NSNumber *)cy_freeDeviceSize;
@end
