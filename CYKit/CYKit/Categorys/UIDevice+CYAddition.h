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
 get current device system version,eg. ios 8.1

 @return current system version
 */
+ (NSString *)cy_systemVersion;

/**
 machine name ,eg. iPhone2,1 => iPhone3GS iPhone3,1 => iPhone4

 @return machine name, not iPhone 4,iPhone 3GS, otherwise iPhone2,1 iPhone3,1
 */
+ (NSString *)cy_deviceName;

/**
 ip address for wifi, should connect with wifi..,if not ,return nil

 @return device current ip address for wifi
 */
+ (NSString *)cy_ipAddressWifi;

/**
 ip address for cell, should connect with 3G,4G...,if not ,return nil

 @return device current ip address for cell
 */
+ (NSString *)cy_ipAddressCell;

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

/**
 check if device is Ipad

 @return YES/NO
 */
+ (BOOL)cy_isIpad;

/**
 check if device is simulator

 @return YES/NO
 */
+ (BOOL)cy_isSimulator;

/**
 check if device is JailBroken

 @return YES/NO
 */
+ (BOOL)cy_isJailBroken;

/**
 check if device can make phone  call

 @return YES/NO
 */
+ (BOOL)cy_canMakePhoneCall NS_EXTENSION_UNAVAILABLE_IOS("ios extension is not available");

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
