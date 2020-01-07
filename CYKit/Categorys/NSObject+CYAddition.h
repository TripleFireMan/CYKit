//
//  NSObject+CYAddition.h
//  AFNetworking
//
//  Created by 成焱 on 2019/9/10.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CYAddition)

+ (instancetype) cy_shareInstance;

+ (void) cy_SwizzleClass:(Class)clazz
        originalSelector:(SEL)sel
              swizzleSel:(SEL)swizzleSel;


@end

NS_ASSUME_NONNULL_END
