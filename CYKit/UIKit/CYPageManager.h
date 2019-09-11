//
//  TDHomePageManager.h
//  Tudou4iPhone
//
//  Created by lijun on 17/1/22.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYPageMenu.h"

@protocol CYHomePageDelegate;

@interface CYHomePageManagerItem : NSObject
// 页面
@property (nonatomic, strong) UIViewController<CYHomePageDelegate> *page;

// 复用Id
@property (nonatomic, strong) NSString *pageId;
// 页面下标
@property (nonatomic, assign) NSInteger index;
@end


@class CYPageManager;
@protocol CYHomePageManagerDelegate <NSObject>
// 设置页数
-(NSInteger) numberOfPagesInPageManager:(CYPageManager *)pageManager;
// 页面复用id
-(NSString *) pageManager:(CYPageManager *)pageManager pageIdForPageAtIndex:(NSInteger)index;
// 页面类名
-(NSString *) pageManager:(CYPageManager *)pageManager classNameForPageAtIndex:(NSInteger)index;
// 复用页面
-(void) pageManager:(CYPageManager *)pageManager reusePage:(UIViewController *)page atIndex:(NSInteger)index;
// 页面标题
-(NSString *) pageManager:(CYPageManager *)pageManager titleForPageAtIndex:(NSInteger)index;

@optional

/**
 * lijian 2017-08-23
 * 回调，根据index 得到TDHomeMenuModel
 */
//-(TDHomeMenuModel *) pageManager:(TDPageManager *)pageManager modelForPageAtIndex:(NSInteger)index;

-(CYPageMenuItem *) pageManager:(CYPageManager *)pageManager menuItemForPageAtIndex:(NSInteger)index;

// title字体大小
-(CGFloat) fontSizeForMenuItem DEPRECATED_MSG_ATTRIBUTE("已废弃, 使用menuFont代替");
- (UIFont *) menuFont;
- (UIFont *) menuSelectFont;

// 页面激活
-(void) pageManager:(CYPageManager *)pageManager didActivatePage:(UIViewController *)page AtIndex:(NSInteger)index;
// 页面失活
-(void) pageManager:(CYPageManager *)pageManager didDeactivatePage:(UIViewController *)page AtIndex:(NSInteger)index;
-(void) pageManager:(CYPageManager *)pageManager selectedIndexWillChangeFrom:(NSInteger)oldIndex to:(NSInteger)newIndex byMenuView:(BOOL)byMenuView;

// 选中项变更。byMenuView表示此次切换是否由菜单点击触发
-(void) pageManager:(CYPageManager *)pageManager selectedIndexDidChangeFrom:(NSInteger)oldIndex to:(NSInteger)newIndex byMenuView:(BOOL)byMenuView;

// 页面正在滑动
-(void) pageManager:(CYPageManager *)pageManager pageAppearProgress:(CGFloat)progress toIndex:(NSInteger)newIndex;
@end

// 子页面协议
@protocol CYHomePageDelegate <NSObject>
@optional
// 子页面开始复用
-(void) pageBeginReuseInPageManager:(CYPageManager *)pageManager;
// 子页面结束复用
-(void) pageEndReuseInPageManager:(CYPageManager *)pageManager;

// 子页面将激活
-(void) pageWillActivateInPageManager:(CYPageManager *)pageManager;
// 子页面已激活
-(void) pageDidActivateInPageManager:(CYPageManager *)pageManager;

// 子页面将失活
-(void) pageWillDeactivateInPageManager:(CYPageManager *)pageManager;
// 子页面已失活
-(void) pageDidDeactivateInPageManager:(CYPageManager *)pageManager;

// 子页面触发刷新(TabBar再次点击选中)
-(void) pageDidTriggerRefreshInPagesManager:(CYPageManager *)pageManager;

@end


@interface CYPageManager : NSObject

// 容器控制器
@property (nonatomic, weak) UIViewController *containerController;

/**
 * ScrollView
 */
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
- (void)setupScrollViewWithFrame:(CGRect)frame;
- (void)setupScrollViewWithFrame:(CGRect)frame class:(Class)cls;

/**
 *  Tab Menu
 */

///页签菜单
@property (nonatomic, strong, readonly) CYPageMenu *menuView;

// 初始化menuView
- (void)setupMenuViewWithFrame:(CGRect)frame;

///刷新菜单标题、角标
- (void)reloadMenuItems;


@property (nonatomic, weak) id<CYHomePageManagerDelegate>delegate;

// 页数
@property (nonatomic, assign, readonly) NSInteger numberOfPages;
// 页间距 默认6.0
@property (nonatomic, assign) CGFloat pageSpacing;

// 刷新页面
-(void) reloadPages;

-(void) reloadPagesToFirstMenu;
// 跳转到指定的index，并刷新页面
-(void) reloadPagesToDesignatedIndex:(NSUInteger)index;

/**
 * Selected
 */
// 当前页面
@property (nonatomic, weak, readonly) UIViewController<CYHomePageDelegate> *selectedPage;
// 当前页面下标
@property (nonatomic, readonly) NSInteger indexForSelectedPage;
//更新选中项
-(void) updateSelectedIndex:(NSInteger)selectedIndex;

/**
 * Active
 */
// 页面是否为激活状态
@property (nonatomic, readonly) BOOL active;
///将进入激活状态
- (void)willActivateAnimated:(BOOL)animated;
///已进入激活状态
- (void)didActivateAnimated:(BOOL)animated;
///将进入非激活状态
- (void)willDeactivateAnimated:(BOOL)animated;
///已进入非激活状态
- (void)didDeactivateAnimated:(BOOL)animated;


// 正在使用的页面
@property (nonatomic, strong) NSMutableArray *usingPagesArray;


@end
























