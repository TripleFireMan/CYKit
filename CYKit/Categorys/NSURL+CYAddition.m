//
//  NSURL+CYAddition.m
//  CYKit
//
//  Created by 成焱 on 2019/11/15.
//

#import "NSURL+CYAddition.h"
#import <sys/xattr.h>


@implementation NSURL (CYAddition)
- (BOOL) cy_addSkipToiCloud
{
    const char * filePath = [[self path] fileSystemRepresentation];
    const char * attribute = "com.apple.MobileBackup";
    u_int8_t arrValue = 1;
    int result = setxattr(filePath,attribute,&arrValue,sizeof(arrValue),0,0);
    return result == 0;
}
@end
