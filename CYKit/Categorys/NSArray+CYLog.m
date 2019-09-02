//
//  NSArray+CYLog.m
//  CYKit
//
//  Created by 成焱 on 2019/9/2.
//

#import "NSArray+CYLog.h"
#import "NSString+CYLog.h"
#import <objc/runtime.h>

static inline void cy_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector)
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

@implementation NSArray (CYLog)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cy_swizzleSelector([self class], @selector(descriptionWithLocale:indent:), @selector(cy_descriptionWithLocale:indent:));
    });
}

- (NSString *)cy_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [self cy_descriptionWithLocale:locale indent:level].unicodeString;
}


@end
