//
//  TDHomePageManager.m
//  Tudou4iPhone
//
//  Created by lijun on 17/1/22.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "CYPageManager.h"
#import <objc/message.h>
#import "CYPageScrollView.h"
#import "CYKitDefines.h"

@implementation CYHomePageManagerItem
@end

@interface CYPageManager ()<UIScrollViewDelegate, CYPageMenuDelegate>
// 等待使用的复用页面
@property (nonatomic, strong) NSMutableDictionary *reusePagesDictionary;
// 当前选中页
@property (nonatomic, strong) CYHomePageManagerItem *selectedPageItem;
// 左右预加载页面数量
@property (nonatomic, assign) NSInteger preloadDepth;
@end

@implementation CYPageManager

-(instancetype) init {
    self = [super init];
    if (self) {
        _preloadDepth = 1;
        _pageSpacing = 6.0;
    }
    return self;
}

#pragma mark-ScrollView

-(void) setupScrollViewWithFrame:(CGRect)frame {
    [self setupScrollViewWithFrame:frame class:[CYPageScrollView class]];
}

-(void) setupScrollViewWithFrame:(CGRect)frame class:(__unsafe_unretained Class)cls {
    CGRect scrollFrame = CGRectZero;
    scrollFrame.origin.x = round(frame.origin.x);
    scrollFrame.origin.y = round(frame.origin.y);
    scrollFrame.size.width = round(frame.size.width + self.pageSpacing);
    scrollFrame.size.height = round(frame.size.height);

    Class ScrollClass = cls;
    if (!ScrollClass) {
        ScrollClass = [UIScrollView class];
    }
    
    _scrollView = [[ScrollClass alloc] initWithFrame:scrollFrame];
    self.scrollView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1.0];
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
}

#pragma mark-Menu

-(void) setupMenuViewWithFrame:(CGRect)frame {
    _menuView = [[CYPageMenu alloc] initWithFrame:frame];
    _menuView.delegate = self;
}

//-(void) resizeMenuViewFrame:(CGRect)frame {
//    _menuView.frame = frame;
//    [_menuView refreshMenuItems];
//    [_menuView updateGradientLayerFrame];
//}

//-(void) handleUIWithXOffset:(CGFloat)xOffset {
//    CGRect frame = self.menuView.frame;
//    frame.origin.x = xOffset;
//    self.menuView.frame = frame;
//}

// 刷新菜单标题
-(void) reloadMenuItems {
    // 页数与菜单项不一致
    if (self.numberOfPages != self.menuView.menuItems.count) return;
    for (NSInteger i = 0; i < self.numberOfPages; i++) {
        CYPageMenuItem *menuItem = self.menuView.menuItems[i];
        menuItem.title = [self.delegate pageManager:self titleForPageAtIndex:i];
    }
    [self.menuView refreshMenuItems];
}

#pragma mark-Active

-(void) willActivateAnimated:(BOOL)animated {
    _active = YES; //保证willActivate回调可发出
    [self p_updatePage:_selectedPageItem active:YES finish:NO];
}

// 已经进入激活状态
-(void) didActivateAnimated:(BOOL)animated {
    [self p_updatePage:self.selectedPageItem active:YES finish:YES];
    //页面激活时，居中显示菜单选中项，并恢复移动进度（解决因移动过程中切换页面引起的界面异常）。
    [self.menuView updateProgress:1.0 toIndex:_indexForSelectedPage];
}

// 将进入非激活状态
-(void) willDeactivateAnimated:(BOOL)animated {
    _active = NO;
    [self p_updatePage:self.selectedPageItem active:NO finish:NO];
}

// 已进入非激活状态
-(void) didDeactivateAnimated:(BOOL)animated {
    [self p_updatePage:self.selectedPageItem active:NO finish:YES];
}

#pragma mark-Selected

-(UIViewController<CYHomePageDelegate> *) selectedPage {
    return self.selectedPageItem.page;
}

-(void) updateSelectedIndex:(NSInteger)selectedIndex {
    [self p_updateSelectedIndex:selectedIndex byMenuView:NO];
}

#pragma mark-ReloadPages

-(void) reloadPagesToFirstMenu {
    [self reloadPagesToDesignatedIndex:0];
}

-(void) reloadPagesToDesignatedIndex:(NSUInteger)index {
    _indexForSelectedPage = index;
    [self reloadPages];
}

-(void) reloadPages {

    // 移除并保存使用中的页面，等待复用
    for (NSInteger i = 0; i < self.usingPagesArray.count; i++) {
        CYHomePageManagerItem *pageItem = self.usingPagesArray[i];
        [self p_removeUsingPageItem:pageItem];
        i--;
    }
    
    // 更新数据源
    _numberOfPages = [self.delegate numberOfPagesInPageManager:self];
    _indexForSelectedPage = MIN(self.indexForSelectedPage, self.numberOfPages);
    
    // 刷新容器视图
    CGFloat contentWidth = round(CGRectGetWidth(self.scrollView.frame));
    CGFloat contentHeight = round(CGRectGetHeight(self.scrollView.frame));
    self.scrollView.contentSize = CGSizeMake(contentWidth*self.numberOfPages, contentHeight);
    
    // 滚动到当前选中页
    [self p_scrollToSelectedPage];
    
    // 预加载页面
    NSInteger fromIndex = CY_CLAMP(self.indexForSelectedPage-self.preloadDepth, 0, self.numberOfPages-1);
    NSInteger toIndex = CY_CLAMP(self.indexForSelectedPage+self.preloadDepth, 0, self.numberOfPages-1);
    
    for (NSInteger i = fromIndex; i <= toIndex; i++) {
        [self p_appendUsingPageItemWithIndex:i];
    }
    
    // 刷新标签菜单
    if (self.menuView) {
        if ([self.delegate respondsToSelector:@selector(pageManager:menuItemForPageAtIndex:)]) {
            NSMutableArray *menuItems = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < self.numberOfPages; i++) {
                CYPageMenuItem *menuItem = [self.delegate pageManager:self menuItemForPageAtIndex:i];
                if (menuItem) {
                    [menuItems addObject:menuItem];
                }
            }
            [self.menuView setMenuItems:menuItems selectedIndex:self.indexForSelectedPage];

        }
    }
}

#pragma mark-TDPageMenuDelegate

-(void) homeMenu:(CYPageMenu *)menu didSelectMenuItem:(CYPageMenuItem *)menuItem atIndex:(NSInteger)index {
    [self p_updateSelectedIndex:index byMenuView:YES];
}

-(void) homeMenu:(CYPageMenu *)menu selectSameIndex:(NSInteger)index {
    if ([self.selectedPageItem.page respondsToSelector:@selector(pageDidTriggerRefreshInPagesManager:)]) {
        [self.selectedPageItem.page pageDidTriggerRefreshInPagesManager:self];
    }
}

-(CGFloat) fontSizeForHomeMenu {
    if ([self.delegate respondsToSelector:@selector(fontSizeForMenuItem)]) {
        return [self.delegate fontSizeForMenuItem];
    }
    // 默认字体是15
    return 15.0;
}

- (UIFont *) normalFont
{
    if ([self.delegate respondsToSelector:@selector(menuFont)]) {
        return [self.delegate menuFont];
    }
    return CYPingFangSCRegular(16);
}

- (UIFont *) selectedFont
{
    if ([self.delegate respondsToSelector:@selector(menuSelectFont)]) {
        return [self.delegate menuSelectFont];
    }
    return CYPingFangSCMedium(18);
}


#pragma mark-UIScrollViewDelegate

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger toIndex = -1;
    CGFloat progress = (scrollView.contentOffset.x - CGRectGetMinX(self.selectedPageItem.page.view.frame))/CGRectGetWidth(scrollView.frame);
    if (progress >= 0.001) {
        toIndex = self.indexForSelectedPage + 1;
    } else if (progress <= -0.001) {
        progress = -progress;
        toIndex = self.indexForSelectedPage - 1;
    }
    
    if (toIndex != -1) {
        if (progress >= 0.999) {
            // 完成切换
            [self p_updateSelectedIndexFromScrollView];
        } else {
            // 正在切换
            [self.menuView updateProgress:progress toIndex:toIndex];
            
            if ([self.delegate respondsToSelector:@selector(pageManager:pageAppearProgress:toIndex:)]) {
                [self.delegate pageManager:self pageAppearProgress:progress toIndex:toIndex];
            }
        }
    }
}

-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self p_updateSelectedIndexFromScrollView];
    }
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self p_updateSelectedIndexFromScrollView];
}

-(void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self p_updateSelectedIndexFromScrollView];
}

#pragma mark-private

-(void) p_scrollToSelectedPage {
    //注：不要在willSelectMenuItem回调里修改offset，否则将触发scrollViewDidScroll里的滚动切换统计。
    //注：不要直接修改contentOffset属性，否则可能引起界面异常
    
    CGRect pageFrame = self.scrollView.bounds;
    pageFrame.origin.x = round(CGRectGetWidth(self.scrollView.frame) * self.indexForSelectedPage);
    [self.scrollView scrollRectToVisible:pageFrame animated:NO]; //滚动到当前选中页
}

-(void) p_updatePage:(CYHomePageManagerItem *)pageItem active:(BOOL)active finish:(BOOL)finish {
    if (!pageItem.page) return;
    if (!_active && active) return; //当前页面被遮盖，忽略子页面激活回调
    
    SEL selector = nil;
    if (active && !finish) {
        selector = @selector(pageWillActivateInPageManager:);
    } else if (active && finish) {
        selector = @selector(pageDidActivateInPageManager:);
    } else if (!active && !finish) {
        selector = @selector(pageWillDeactivateInPageManager:);
    } else if (!active && finish) {
        selector = @selector(pageDidDeactivateInPageManager:);
    }
    
    if (active && finish) {
        if ([self.delegate respondsToSelector:@selector(pageManager:didActivatePage:AtIndex:)]) {
            [self.delegate pageManager:self didActivatePage:pageItem.page AtIndex:pageItem.index];
        }
    }
    
    if (!active && finish) {
        if ([self.delegate respondsToSelector:@selector(pageManager:didDeactivatePage:AtIndex:)]) {
            [self.delegate pageManager:self didDeactivatePage:pageItem.page AtIndex:pageItem.index];
        }
    }
    
    if ([pageItem.page respondsToSelector:selector]) {
        // 使用objc_msgSend代替 performSelector,消除编译器关于可能引起内存泄漏的警告
        ((void (*)(id, SEL, CYPageManager *)) objc_msgSend)(pageItem.page, selector, self);
//        [pageItem.page performSelector:selector withObject:self];
    }
}

-(void) p_updateSelectedIndex:(NSInteger)selectedIndex byMenuView:(BOOL)byMenuView {
    if (selectedIndex < 0 || selectedIndex >= self.numberOfPages) return;
    if (self.indexForSelectedPage != selectedIndex) {
        NSInteger previousIndex = self.indexForSelectedPage;
        _indexForSelectedPage = selectedIndex;
        
        if ([self.delegate respondsToSelector:@selector(pageManager:selectedIndexWillChangeFrom:to:byMenuView:)]) {
            [self.delegate pageManager:self selectedIndexWillChangeFrom:previousIndex to:selectedIndex byMenuView:byMenuView];
        }
        
        // 移除复用范围以外的页面
        NSInteger fromIndex = CY_CLAMP(selectedIndex-self.preloadDepth, 0, self.numberOfPages-1);
        NSInteger toIndex = CY_CLAMP(selectedIndex+self.preloadDepth, 0, self.numberOfPages-1);
        
        NSMutableArray *appendIndex = @[].mutableCopy;
        for (NSInteger i = fromIndex; i <= toIndex; i++) {
            [appendIndex addObject:@(i)];
        }
        
        for (NSInteger i = 0; i < self.usingPagesArray.count; i++) {
            CYHomePageManagerItem *pageItem = self.usingPagesArray[i];
            
            //不在预加载范围内，移除
            if (pageItem.index < fromIndex || pageItem.index > toIndex) {
                CYHomePageManagerItem *pageItem = self.usingPagesArray[i];
                [self p_removeUsingPageItem:pageItem];
                i--;
            } else {
                // 已复用
                [appendIndex removeObject:@(pageItem.index)];
                // 更新选中页
                if (pageItem.index == selectedIndex) {
                    [self p_updateSelectedPageWithItem:pageItem];
                }
            }
        }
        
        // 刷新容器视图
        for (NSInteger i = 0; i < appendIndex.count; i++) {
            NSInteger index = [appendIndex[i] integerValue];
            [self p_appendUsingPageItemWithIndex:index];
        }
        
        // 显示选中页面
        [self p_scrollToSelectedPage];
        
        // 刷新标签菜单选中项
        if (!byMenuView) {
            [self.menuView updateSelectedIndex:self.indexForSelectedPage];
        }
//        [self.menuView updateSelectedIndex:self.indexForSelectedPage];
        
        // 选中项变更回调
        if ([self.delegate respondsToSelector:@selector(pageManager:selectedIndexDidChangeFrom:to:byMenuView:)]) {
            [self.delegate pageManager:self selectedIndexDidChangeFrom:previousIndex to:selectedIndex byMenuView:byMenuView];
        }
    }
}

// 移除正在使用的页面
-(void) p_removeUsingPageItem:(CYHomePageManagerItem *)pageItem {
    // 保存到复用数据源
    [self p_saveReusePageItem:pageItem];
    
    // 移除视图
    UIViewController<CYHomePageDelegate> *page = pageItem.page;
    [page.view removeFromSuperview];
    
    // 移除数据源
    [self.usingPagesArray removeObject:pageItem];
    
    // 清楚选中页（复用回调前）
    if (pageItem.index == self.selectedPageItem.index) {
        [self p_updateSelectedPageWithItem:nil];
    }
    
    // 结束复用回调
    if ([page respondsToSelector:@selector(pageEndReuseInPageManager:)]) {
        [page pageEndReuseInPageManager:self];
    }
}

// 更新选中页
-(void) p_updateSelectedPageWithItem:(CYHomePageManagerItem *)pageItem {
    if (self.selectedPageItem) {
        [self p_updatePage:self.selectedPageItem active:NO finish:NO];
        [self p_updatePage:self.selectedPageItem active:NO finish:YES];
    }
    _selectedPageItem = pageItem;
    
    if (self.selectedPageItem) {
        [self p_updatePage:self.selectedPageItem active:YES finish:NO];
        [self p_updatePage:self.selectedPageItem active:YES finish:YES];
    }
}

-(void) p_saveReusePageItem:(CYHomePageManagerItem *)pageItem {
    // 无效复用id或者无复用页面
    if (!pageItem.pageId.length || !pageItem.page) return;
    NSMutableArray *resuePagesArray = self.reusePagesDictionary[pageItem.pageId];
    if (!resuePagesArray) {
        resuePagesArray = [NSMutableArray array];
        self.reusePagesDictionary[pageItem.pageId] = resuePagesArray;
    }
    [resuePagesArray addObject:pageItem];
}

// 添加正在使用的页面
-(void) p_appendUsingPageItemWithIndex:(NSInteger)index {
    NSString *pageId = [self.delegate pageManager:self pageIdForPageAtIndex:index];
    // 获取可以复用的页面
    CYHomePageManagerItem *pageItem = [self p_loadReusePageItemWithPageId:pageId];
    if (!pageItem) {
        pageItem = [[CYHomePageManagerItem alloc] init];
        pageItem.pageId = pageId;
    }
    pageItem.index = index;
    UIViewController<CYHomePageDelegate> *page = pageItem.page;
    if (!page) {
        NSString *className = [self.delegate pageManager:self classNameForPageAtIndex:index];
        Class PageClass = NSClassFromString(className);
        if (PageClass) {
            page = [[PageClass alloc] init];
        }
        pageItem.page = page;
    }
    
    // 标记为正在使用的页面
    [self.usingPagesArray addObject:pageItem];
    
    // 复用回调（加载页面前）
    [self.delegate pageManager:self reusePage:page atIndex:index];
    
    //添加页面视图
    CGFloat contentWidth = round(CGRectGetWidth(self.scrollView.frame)); //容器视图宽度
    CGFloat contentHeight = round(CGRectGetHeight(self.scrollView.frame)); //容器视图高度
    CGFloat pageWidth = round(contentWidth - self.pageSpacing); //子页面视图宽度
    CGFloat pageHeight = contentHeight; //子页面视图高度
    
    CGRect pageFrame = CGRectZero;
    pageFrame.origin.x = contentWidth * index;
    pageFrame.size.width = pageWidth;
    pageFrame.size.height = pageHeight;
    
    page.view.frame = pageFrame;
    
    if (nil != page.view) { // Fix:  nil passed to a callee that requires a non-null 1st parameter
        [self.scrollView addSubview:page.view];
    }

    //开始复用回调（加载页面后）
    if ([page respondsToSelector:@selector(pageBeginReuseInPageManager:)]) {
        [page pageBeginReuseInPageManager:self];
    }
    
    //更新选中页（复用回调后）
    if (pageItem.index == self.indexForSelectedPage) {
        [self p_updateSelectedPageWithItem:pageItem];
    }
}

// 获取可复用页面
-(CYHomePageManagerItem *) p_loadReusePageItemWithPageId:(NSString *)pageId {
    if (!pageId.length) return nil;
    NSMutableArray *reusePagesArray = self.reusePagesDictionary[pageId];
    // 无可用页面
    if (!reusePagesArray.count) return nil;
    
    CYHomePageManagerItem *pageItem = [reusePagesArray firstObject];
    if (pageItem) {
        [reusePagesArray removeObject:pageItem];
    }
    return pageItem;
}

// 刷新容器视图当前选中页，预加载左右页面
-(void) p_updateSelectedIndexFromScrollView {
    NSInteger selectedIndex = round(self.scrollView.contentOffset.x / CGRectGetWidth(self.scrollView.frame));
    selectedIndex = CY_CLAMP(selectedIndex, 0, self.numberOfPages-1);
    [self updateSelectedIndex:selectedIndex];
}

#pragma mark-getter

-(NSMutableDictionary *) reusePagesDictionary {
    if (!_reusePagesDictionary) {
        _reusePagesDictionary = [[NSMutableDictionary alloc] init];
    }
    return _reusePagesDictionary;
}

-(NSMutableArray *) usingPagesArray {
    if (!_usingPagesArray) {
        _usingPagesArray = [[NSMutableArray alloc] init];
    }
    return _usingPagesArray;
}


@end
