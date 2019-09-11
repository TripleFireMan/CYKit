//
//  CYPageMenu.h
//  Tudou4iPhone
//
//  Created by lijun on 17/1/25.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYPageMenuItem.h"

@class CYPageMenu;
@protocol CYPageMenuDelegate <NSObject>
// 字体大小
-(CGFloat) fontSizeForHomeMenu;

@optional
// 将要点击菜单项
-(void) homeMenu:(CYPageMenu *)menu willSelectMenuItem:(CYPageMenuItem *)menuItem atIndex:(NSInteger)index;
// 已经点击菜单项
-(void) homeMenu:(CYPageMenu *)menu didSelectMenuItem:(CYPageMenuItem *)menuItem atIndex:(NSInteger)index;
// 选中项变更
-(void) homeMenu:(CYPageMenu *)menu selectedIndexDidChangeFrom:(NSInteger)oldIndex to:(NSInteger)newIndex;
// 选中当前tab
-(void) homeMenu:(CYPageMenu *)menu selectSameIndex:(NSInteger)index;

@end

// 主题类型
// http://11.239.180.19/uispec/html/phone/6.16%E9%A6%96%E9%A1%B5UGC%E9%BB%98%E8%AE%A4%E9%A1%B5%E8%AE%BE%E8%AE%A1%E5%85%A5%E5%8F%A3%E5%8F%98%E6%9B%B4/#artboard0
typedef NS_ENUM(NSInteger, CYPageMenuThemeType) {
    CYPageMenuThemeTypeDefault, // 默认主题（17号字体、选中指示栏在下方）
    CYPageMenuThemeTypeSec,  // 二级菜单主题 (14号字体、选中指示栏在title外围)
};

// menu间隔类型
typedef NS_ENUM(NSInteger, CYPageMenuLevel) {
    CYPageMenuLevelDefault,   // 默认间距
    CYPageMenuLevelFirst,       // 一级menu（大间距、没有左右maskLayer）
};

@interface CYPageMenu : UIView
// 容器视图
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
// 主题样式
@property (nonatomic, assign) CYPageMenuThemeType themeType;
@property (nonatomic, assign) CYPageMenuLevel levelType;

@property (nonatomic, weak) id<CYPageMenuDelegate>delegate;
@property (nonatomic, strong, readonly) NSArray<CYPageMenuItem *> *menuItems;
// 选中项的index
@property (nonatomic, readonly) NSInteger selectedIndex;
// 选中颜色 调用refreshMenuItems刷新
@property (nonatomic, strong) UIColor *selectedColor;
// 未选中颜色 调用refreshMenuItems刷新
@property (nonatomic, strong) UIColor *unselectedColor;
// 菜单内边距。调用refreshMenuItems刷新。
@property (nonatomic) UIEdgeInsets padding;
// 内容不足时的对齐方式，默认居中
@property (nonatomic) UIViewContentMode contentMode;
// 更新选中项
-(void) setMenuItems:(NSArray<CYPageMenuItem *> *)menuItems selectedIndex:(NSInteger)selectedIndex;
// 刷新菜单项
-(void) refreshMenuItems;
// 更新选中项
-(void) updateSelectedIndex:(NSInteger)selectedIndex;
// 更新滚动条进度
-(void) updateProgress:(CGFloat)progress toIndex:(NSInteger)index;
// 居中显示选中项
-(void) scrollToSelectedIndex;
// 更新遮罩
-(void) updateGradientLayerFrame;


@end


@interface UIViewController (CYPageMenu)
// 标签菜单项
@property (nonatomic, strong) CYPageMenuItem *menuItem;
// 标签菜单
@property (nonatomic, weak) CYPageMenu *menu;
@end









































