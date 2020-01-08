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

/// runtime方法替换
+ (void) cy_SwizzleClass:(Class)clazz
        originalSelector:(SEL)sel
              swizzleSel:(SEL)swizzleSel;
/// 每个类都可以有单例
+ (instancetype) cy_shareInstance;
/// 缓存本地
- (void) cy_save;
/// 清理数据
- (void) cy_clean;
@end

NS_ASSUME_NONNULL_END
