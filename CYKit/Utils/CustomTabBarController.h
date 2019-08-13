//
//  CustomTabBarController.h
//  CustomTabBarDemo
//
//  Created by chengyan on 17/2/21.
//  Copyright © 2017年 Youku.inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBar.h"
#import "CustomBarButton.h"

@protocol CustomTabBarControllerDelegate <NSObject>

@optional
/// 回调方法
- (void)customTabBarControllerDidSelectAtIndex:(NSInteger)index
                                  customTabBar:(CustomTabBar *)tabBar
                            theSameToProAction:(BOOL)theSame;
@end

@interface CustomTabBarController : UITabBarController

/// 提供对外访问的接口
@property (nonatomic, strong) CustomTabBar *customTabBar;

/// 单例
+ (instancetype)shareInstance;

/// 添加观察者
- (void)addListener:(id <CustomTabBarControllerDelegate>) listerner;

/// 移除观察者
- (void)removeListener:(id <CustomTabBarControllerDelegate>) listener;

/// 添加子视图控制器到TabBarController
- (void)addChildViewController:(UIViewController *)childController
                         title:(NSString *)title
                         image:(UIImage *)image
                 selectedImage:(UIImage *)selectedImage
                         color:(UIColor *)color
                 selectedColor:(UIColor *)selectedColor;

/// 设置单个TabBar按钮的标题、颜色等
- (void)setCustomTabBarButtonTitle:(NSString *)title
                             color:(UIColor *)color
                     selectedColor:(UIColor *)selectedColor
                             image:(UIImage *)image
                     selectedImage:(UIImage *)selectedImage
                             index:(NSInteger)index;

/// 给某个BarButtonItem设置标题
- (void)setTitle:(NSString *)title index:(NSInteger)index animation:(BOOL)animated;

/// 根据index获取当前VC的title
- (NSString *)titleForIndex:(NSInteger)index;
@end
