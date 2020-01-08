
//
//  NSObject+CYAddition.m
//  AFNetworking
//
//  Created by 成焱 on 2019/9/10.
//

#import "NSObject+CYAddition.h"
#import <objc/runtime.h>
#import "FastCoder.h"
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
    @synchronized (self) {
        Class clazz = [self class];
        id instance = objc_getAssociatedObject(clazz, @"cy_shareInstanceOBJ");
        if (!instance) {
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:NSStringFromClass([self class])];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
            id obj = [FastCoder objectWithData:data];
            if (obj && [obj isKindOfClass:[self class]]) {
                instance = obj;
            }
            else{
                instance = [[clazz alloc] init];
            }
            objc_setAssociatedObject(self, @"cy_shareInstanceOBJ", instance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        return instance;
    }
}

- (void) cy_clean
{
    @synchronized (self) {
        unsigned int pro_count = 0;
        // 获取该类中所有属性列表
        objc_property_t *properties = class_copyPropertyList([self class], &pro_count);
        // for循环遍历所有属性
        for (int i = 0; i < pro_count; i ++) {
            objc_property_t property = properties[i];
            // 得到当前属性的名字（字符串形式）
            NSString *propertyName = [NSString stringWithFormat:@"%s", property_getName(property)];
            NSLog(@"propertyName:%@",propertyName);
            // 使用KVC方式得到该属性的值
            id propertyValue = [self valueForKey:(NSString *)propertyName];
            
            // null的就不用管了
            if (!propertyValue ||
                [propertyValue isKindOfClass:[NSNull class]]) {
                continue;
            }
            if ([propertyName isEqualToString:@"hash"] ||
                [propertyName isEqualToString:@"description"]||
                [propertyName isEqualToString:@"debugDescription"]||
                [propertyName isEqualToString:@"superclass"]) {
                continue;
            }
            
            // !!!:同样通过KVC的方式赋值

            if ([propertyValue isKindOfClass:[NSString class]]) {
                // 字符串类型
                [self setValue:@"" forKey:propertyName];
                NSLog(@"--> 清理用户信息[%@]成功 NSString:%@",propertyName,propertyValue);
            }
            else if ([propertyValue isKindOfClass:[NSNumber class]]) {
                // bool int float long ...
                [self setValue:[NSNumber numberWithInteger:0] forKey:propertyName];
                NSLog(@"--> 清理用户信息[%@]成功 NSNumber:%@",propertyName,propertyValue);
            }
            else if ([propertyValue isKindOfClass:[NSMutableDictionary class]] ||
                     [propertyValue isKindOfClass:[NSDictionary class]]) {
                // 字典
                [self setValue:@{} forKey:propertyName];
                NSLog(@"--> 清理用户信息[%@]成功 NSDictionary:%@",propertyName,propertyValue);
            }
            else if ([propertyValue isKindOfClass:[NSMutableArray class]] ||
                     [propertyValue isKindOfClass:[NSArray class]]) {
                // 数组
                [self setValue:@[] forKey:propertyName];
                NSLog(@"--> 清理用户信息[%@]成功 NSArray:%@",propertyName,propertyValue);
            }
            else {
                // 其他未知类型 包括data
                // 这里还可以增加其他判断...
                [self setValue:nil forKey:propertyName];
                NSLog(@"--> 清理用户信息[%@]成功 其他未知类型:%@",propertyName,propertyValue);
            }
        }
        // 释放
        free(properties);
    }
    
    
    /*
    // 置空父类(PowerStationForHouseholdModel)的属性值
    pro_count = 0;
    objc_property_t *properties_super = class_copyPropertyList([self superclass], &pro_count);
    for (int i = 0; i < pro_count; i ++) {
        objc_property_t property = properties_super[i];
        NSString *propertyName = [NSString stringWithFormat:@"%s", property_getName(property)];
        // 可以自己根据要求修改
        [self setValue:nil forKey:propertyName];
    }
    free(properties_super);
    */
}

- (void) cy_save
{
    @synchronized (self) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:NSStringFromClass([self class])];
        NSData *data = [FastCoder dataWithRootObject:self];
        BOOL success = [data writeToURL:[NSURL fileURLWithPath:path] atomically:YES];
        if (success) {
            NSLog(@"%@保存成功",NSStringFromSelector(_cmd));
        }
        else{
            NSLog(@"%@保存失败",NSStringFromSelector(_cmd));
        }
    }
}
@end
