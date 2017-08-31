//
//  UIDevice+CYAddition.m
//  Pods
//
//  Created by chengyan on 2017/8/31.
//
//

#import "UIDevice+CYAddition.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation UIDevice (CYAddition)

+ (NSString *)cy_systemVersion
{
    static NSString * version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [UIDevice currentDevice].systemVersion;
    });
    return version;
}

+ (NSString *)cy_deviceName
{
    size_t size;
    
    // Set 'oldp' parameter to NULL to get the size of the data
    // returned so we can allocate appropriate amount of space
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    // Allocate the space to store name
    char *name = malloc(size);
    
    // Get the platform name
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    
    // Place name into a string
    NSString *machine = [NSString stringWithUTF8String:name];
    
    // Done with this
    free(name);
    
    return machine;
}

+ (NSString *)cy_carrier
{
    if(NSClassFromString(@"CTTelephonyNetworkInfo")){
        @try {
            /*  25303 */
            CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
            CTCarrier *carrier = [networkInfo subscriberCellularProvider];
            if ([[carrier carrierName] length] > 0) {
                return [NSString stringWithFormat:@"%@_%@%@", [carrier carrierName], [carrier mobileCountryCode], [carrier mobileNetworkCode]];
            }else{
                return nil;
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {
            ;
        }
    }
    return nil;
}

+ (NSString *)cy_ipAddressWifi
{
    NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in  *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    
    return address;
}

+ (NSString *)cy_ipAddressCell
{
    NSString *address = nil;
    struct ifaddrs *addrs = NULL;
    if (getifaddrs(&addrs) == 0) {
        struct ifaddrs *addr = addrs;
        while (addr != NULL) {
            if (addr->ifa_addr->sa_family == AF_INET) {
                if ([[NSString stringWithUTF8String:addr->ifa_name] isEqualToString:@"pdp_ip0"]) {
                    address = [NSString stringWithUTF8String:
                               inet_ntoa(((struct sockaddr_in *)addr->ifa_addr)->sin_addr)];
                    break;
                }
            }
            addr = addr->ifa_next;
        }
    }
    freeifaddrs(addrs);
    return address;
}

+ (NSString *)cy_macAddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (BOOL)cy_isIpad
{
    static dispatch_once_t onceToken;
    static BOOL isIpad = NO;
    dispatch_once(&onceToken, ^{
        isIpad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return isIpad;
}

+ (BOOL)cy_isSimulator
{
    static dispatch_once_t onceToken;
    static BOOL isSimulator = NO;
    dispatch_once(&onceToken, ^{
        NSString *machionName = [self cy_deviceName];
        if ([machionName isEqualToString:@"x86_84"] || [machionName isEqualToString:@"i386"]) {
            isSimulator = YES;
        }
    });
    return isSimulator;
}

+ (BOOL)cy_isJailBroken
{
    if ([self cy_isSimulator]) return NO;
    
    
    NSArray *paths = @[@"/Applications/Cydia.app",
                       @"/private/var/lib/apt/",
                       @"/private/var/lib/cydia",
                       @"/private/var/stash"];
    for (NSString *path in paths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) return YES;
    }
    
    FILE *bash = fopen("/bin/bash", "r");
    if (bash != NULL) {
        fclose(bash);
        return YES;
    }
    
    NSString *bridgeUUID;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    bridgeUUID = (__bridge_transfer NSString *)string;
    
    NSString *path = [NSString stringWithFormat:@"/private/%@", bridgeUUID];
    if ([@"test" writeToFile : path atomically : YES encoding : NSUTF8StringEncoding error : NULL]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        return YES;
    }
    
    return NO;
}

+ (BOOL)cy_canMakePhoneCall
{
    static dispatch_once_t onceToken;
    static BOOL canMakePhoneCall = NO;
    dispatch_once(&onceToken, ^{
        canMakePhoneCall = [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"tel://"]];
    });
    return canMakePhoneCall;
}


+ (NSNumber *)cy_totalDeviceSize
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

+ (NSNumber *)cy_freeDeviceSize
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}
@end
