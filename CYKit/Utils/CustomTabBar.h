//
//  CustomTabBar.h
//  CustomTabBarDemo
//
//  Created by chengyan on 17/2/21.
//  Copyright © 2017年 Youku.inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBarButton.h"

/// 按钮在TabBar上的Tag偏移位
extern const int customTabBarTagOffset;

@protocol CustomTabBarDelegate <NSObject>

@optional

- (void)changeControllerWithIndex:(NSInteger)index;

@end

@interface CustomTabBar : UIView
{
    @public
    NSInteger _selectedIndex;
}


@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) id <CustomTabBarDelegate> delegateed;

/// 暂未实现，留作以后扩展，可以实现添加中间view之后显示在TabBar最中间
@property (nonatomic, strong) UIView *centerView;

/// 添加按钮
- (void)addChildTabBarButton:(UITabBarItem *)item
                       color:(UIColor *)color
               selectedColor:(UIColor *)selectedColor;

/// 处理按钮点击事件
- (void)handleButtonAction:(UIButton *)button;

/// 根据Index值获取按钮
- (CustomBarButton *)barButtonAtIndex:(NSInteger)index;

/// 设置文本标题，是否用动画
- (void)setTabBarButton:(CustomBarButton *)barButton title:(NSString *)title animated:(BOOL)animated;
@end
