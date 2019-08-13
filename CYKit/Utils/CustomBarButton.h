//
//  CustomBarButton.h
//  CustomTabBarDemo
//
//  Created by chengyan on 17/2/21.
//  Copyright © 2017年 Youku.inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface CustomBarButton : UIControl

/// 用于接收外部传给tabbarController的模型数据
@property (nonatomic, strong) UITabBarItem      *item;
/// 选中态颜色
@property (nonatomic, strong) UIColor           *selectedColor;
/// 正常态颜色
@property (nonatomic, strong) UIColor           *normalColor;
/// 设置红点显示/隐藏
@property (nonatomic, assign, setter=setRedPointHidden:) BOOL redPointHidden;
/// 设置是否被选中
@property (nonatomic, assign) BOOL              isSelected;
/// 标题
@property (nonatomic, strong) NSString          *title;



/// 初始化
- (id)initWithFrame:(CGRect)frame
               item:(UITabBarItem *)item
      selectedColor:(UIColor *)sColor
        normalColor:(UIColor *)nColor;

/// 给按钮添加事件，分为点击事件和双击事件
- (void)addTarget:(id)target action:(SEL)action;

/// 设置标题是否有动画，动画是淡入淡出，渐隐
- (void)setTitle:(NSString *)title animated:(BOOL)animated;
@end

