
//
//  NSObject+CYAddition.m
//  AFNetworking
//
//  Created by 成焱 on 2019/9/10.
//

#import "NSObject+CYAddition.h"
#import <objc/runtime.h>
@implementation NSObject (CYAddition)

+ (void) cy_SwizzleClass:(Class)theClass
        originalSelector:(SEL)originalSelector
              swizzleSel:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(theClass,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(theClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (instancetype) cy_shareInstance
{
    Class clazz = [self class];
    id instance = objc_getAssociatedObject(clazz, @"cy_shareInstanceOBJ");
    if (!instance) {
        instance = [[clazz alloc] init];
        objc_setAssociatedObject(self, @"cy_shareInstanceOBJ", instance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return instance;
}
@end
