//
//  CYUser.m
//  AFNetworking
//
//  Created by 成焱 on 2020/1/7.
//

#import "CYUser.h"
#import "FastCoder.h"
#import <objc/runtime.h>

@implementation CYUser
+ (instancetype) shareInstance
{
    static id user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"CYKitUser"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
        id obj = [FastCoder objectWithData:data];
        if (obj) {
            user = obj;
        }
        else{
            user = [[[self class] alloc] init];
        }
    });
    return user;
}

- (void) logout
{
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
            [propertyName isEqualToString:@"debugDescription"]
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
- (void) save
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"CYKitUser"];
    NSData *data = [FastCoder dataWithRootObject:self];
    BOOL success = [data writeToURL:[NSURL fileURLWithPath:path] atomically:YES];
    if (success) {
        NSLog(@"%@保存成功",NSStringFromSelector(_cmd));
    }
    else{
        NSLog(@"%@保存失败",NSStringFromSelector(_cmd));
    }
}
@end
