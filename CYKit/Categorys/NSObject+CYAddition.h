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

/// 获取资源bundle
static inline NSBundle *CYBundle(NSString *podName){
    NSBundle *main = [NSBundle mainBundle];
    NSString *path = [main pathForResource:podName ofType:@"bundle"];
    NSBundle *curp = [NSBundle bundleWithURL:[NSURL fileURLWithPath:path]];
    return curp;
}


NS_ASSUME_NONNULL_END
