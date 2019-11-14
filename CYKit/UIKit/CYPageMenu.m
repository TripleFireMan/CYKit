//
//  TDPageMenu.m
//  Tudou4iPhone
//
//  Created by lijun on 17/1/25.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "CYPageMenu.h"
#import <objc/runtime.h>
#import "CYPageMenuButton.h"
#import "CYKitDefines.h"
#import "Masonry.h"
#import "UIColor+CYAddition.h"

#define RedDotSignChannelTag 20170823

#define ButtonLabelWidth(btn) (round([btn convertRect:btn.titleLabel.frame toView:self.scrollView].size.width))
#define ButtonLabelX(btn) (round([btn convertPoint:btn.titleLabel.frame.origin toView:self.scrollView].x))
#define ButtonLabelY(btn) (round([btn convertPoint:btn.titleLabel.frame.origin toView:self.scrollView].y))

#define SelectedViewWidthForBtn(btn) (ButtonLabelWidth(btn)*0.8)
#define SelectedViewXForBtn(btn) ButtonLabelX(btn)


//滑块默认宽度
//static const CGFloat kSelectedViewDefaultWidth = 21.0;
//滑块高度
static const CGFloat kSelectedViewHeightDefault = 3.0;
static const CGFloat kSelectedViewHeightSec = 25;


//菜单项高度
static const CGFloat kItemHeight = 44.0;

//菜单项左右内边距
//#define kPaddingItem (IS_IPHONE_6_PLUS ? 13 : 14.5)
#define kPaddingItemBig 20


//菜单字体大小
static const CGFloat kMenuItemFontSize = 15.0;
static const CGFloat kMenuItemFontSizeForPlus = 17.0;
static const CGFloat kMenuItemFontSizeSmall = 14.0;

// 遮罩宽度
static const CGFloat kGradientImageWidth = 32;

@interface CYPageMenu ()<UIScrollViewDelegate>
// 菜单按钮数组，复用
@property (nonatomic,strong) NSMutableArray *itemButtons;
// 滑块视图
@property (nonatomic, strong) UIView *selectedView;
@property (nonatomic, strong) UIImageView *rightGradientImageView;
@property (nonatomic, strong) UIImageView *leftGradientImageView;

@end

@implementation CYPageMenu
@dynamic contentMode;

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeLeft;
        
        _itemButtons = [[NSMutableArray alloc] init];
        _themeType = -1;
        _selectedIndex = -1;
        
        _selectedColor = [UIColor cy_colorWithHexRGBString:@"222222"];
        _unselectedColor = [UIColor cy_colorWithHexRGBString:@"888888"];
        _padding = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0); // #12186220

        _scrollView = [[UIScrollView alloc] init];
        _scrollView.scrollEnabled = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];

//        _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0, kSelectedViewHeight)];
//        _selectedView.backgroundColor = [UIColor colorWithHexRGB:@"FFDD00"];
//        _selectedView.layer.cornerRadius = kSelectedViewHeight/2.0;
//        _selectedView.userInteractionEnabled = NO;
//        [_scrollView addSubview:_selectedView];
        
        _rightGradientImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationShadeRight"]];
        _leftGradientImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationShadeLeft"]];
        _leftGradientImageView.hidden = YES;
        
        [self addSubview:self.leftGradientImageView];
        [self addSubview:self.rightGradientImageView];
        
        [self updateGradientLayerFrame];
        
//#ifdef DEBUG
//        _rightGradientImageView.backgroundColor = [UIColor redColor];
//        _leftGradientImageView.backgroundColor = [UIColor greenColor];
//#endif
        
        self.levelType = CYPageMenuLevelDefault;
        self.themeType = CYPageMenuThemeTypeDefault;
        
    }
    return self;
}

#pragma mark-delegate

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
//    DDLogInfo(@"TDPageMenu:point:%@", NSStringFromCGPoint(point));
    
    // TDPageMenuLevelFirst隐藏遮罩
    if (self.levelType == CYPageMenuLevelFirst) {
        self.rightGradientImageView.hidden = self.leftGradientImageView.hidden = YES;
    } else {
        if ((point.x+CGRectGetWidth(self.bounds)) >= scrollView.contentSize.width) {
            self.rightGradientImageView.hidden = YES;
        } else {
            if (self.rightGradientImageView.hidden) {
                self.rightGradientImageView.hidden = NO;
            }
        }
        
        self.leftGradientImageView.hidden = (point.x <= 0);
    }
}

#pragma mark-public

-(void) setMenuItems:(NSArray<CYPageMenuItem *> *)menuItems selectedIndex:(NSInteger)selectedIndex {
    if (![self.menuItems isEqual:menuItems]) {
        _menuItems = menuItems;
        _selectedIndex = -1;
        // 移除菜单项视图
        [self.itemButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self p_setupMenuItem];
    }
    // 更新选中项
    [self updateSelectedIndex:selectedIndex];
}

-(void) refreshMenuItems {
    // 刷新菜单项
    [self p_setupMenuItem];
    // 刷新滑动视图
    [self updateProgress:1.0 toIndex:self.selectedIndex];
}

-(void) updateGradientLayerFrame {
    [self setNeedsLayout];
}

-(void) setLevelType:(CYPageMenuLevel)levelType {
    if (_levelType != levelType) {
        _levelType = levelType;
        if (_levelType == CYPageMenuLevelFirst) {
            self.rightGradientImageView.hidden = self.leftGradientImageView.hidden = YES;
        } else {
            self.leftGradientImageView.hidden = (self.scrollView.contentOffset.x <= 0);
            if ((self.scrollView.contentOffset.x+CGRectGetWidth(self.bounds)) >= self.scrollView.contentSize.width) {
                self.rightGradientImageView.hidden = YES;
            } else {
                self.rightGradientImageView.hidden = NO;
            }
        }
    }
}

-(void) setThemeType:(CYPageMenuThemeType)themeType {
    if (_themeType != themeType) {
        _themeType = themeType;
        
        if (!_selectedView) {
            _selectedView = [[UIView alloc] init];
            _selectedView.userInteractionEnabled = NO;
            [_scrollView addSubview:_selectedView];
        }
        
        CGFloat height = -1;
        NSString *colorHexStr = nil;
        
        switch (_themeType) {
            case CYPageMenuThemeTypeDefault: {
                height = kSelectedViewHeightDefault;
                colorHexStr = @"3FD7D8";
            } break;
                
            case CYPageMenuThemeTypeSec: {
                height = kSelectedViewHeightSec;
                colorHexStr = @"ececec";
            } break;
        }
        
        
        if (height > 0 && colorHexStr) {
            _selectedView.frame = CGRectMake(0.0, 0.0, 0, height);
            if (!self.showSelectedView) {
                _selectedView.backgroundColor = [[UIColor cy_colorWithHexRGBString:colorHexStr] colorWithAlphaComponent:0];
            }
            else{
                _selectedView.backgroundColor = [UIColor cy_colorWithHexRGBString:colorHexStr];
            }
            _selectedView.layer.cornerRadius = height/2.0;
        }
        
        [self refreshMenuItems];
    }
}



-(void) updateSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex != selectedIndex) {
        [self updateProgress:1.0 toIndex:selectedIndex];
        NSInteger fromIndex = self.selectedIndex;
        _selectedIndex = selectedIndex;
        if ([self.delegate respondsToSelector:@selector(homeMenu:selectedIndexDidChangeFrom:to:)]) {
            [self.delegate homeMenu:self selectedIndexDidChangeFrom:fromIndex to:selectedIndex];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(homeMenu:selectSameIndex:)]) {
            [self.delegate homeMenu:self selectSameIndex:selectedIndex];
        }
    }
}

-(void) scrollToSelectedIndex {
    if (!self.scrollView.scrollEnabled) return;
    
    //以屏幕为中央，居中显示 lijian 2017-08-14
//    CGFloat menuW = round(CGRectGetWidth(self.window.frame)/2);
    CGFloat menuW = round(CGRectGetWidth(self.frame));
    CGFloat minX = 0.0;
    CGFloat maxX = floor(self.scrollView.contentSize.width - menuW);

    CGRect frame = self.scrollView.bounds;
    frame.size.width = menuW;
    // 居中显示滑块
    frame.origin.x = CY_CLAMP(CGRectGetMidX(_selectedView.frame) - menuW / 2.0, minX, maxX);
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (void)updateProgress:(CGFloat)toProgress toIndex:(NSInteger)toIndex
{
    if (toIndex < 0 || toIndex >= _itemButtons.count) return; //目标index不合法
    
    //参数校正
    CGFloat progress = CY_CLAMP(toProgress, 0.0, 1.0);
    UIButton *fromItemButton = (_selectedIndex >= 0 && _selectedIndex < _itemButtons.count) ? _itemButtons[_selectedIndex] : nil;
    UIButton *toItemButton = (toIndex >= 0 && toIndex < _itemButtons.count) ? _itemButtons[toIndex] : nil;

    if (_selectedIndex == toIndex || _selectedIndex < 0) { //目标index与当前index相同，或初始设置时，直接刷新当前选中项
        //菜单项
        UIColor *toColor = (_itemButtons.count > 1) ? _selectedColor : _unselectedColor; //只有一个菜单项时无选中状态
        [toItemButton setTitleColor:toColor forState:UIControlStateNormal];
        toItemButton.titleLabel.font = [self p_selectedFont];
        
        //滑块
        CGRect frame = _selectedView.frame;
        if (self.themeType == CYPageMenuThemeTypeSec) {
            frame.origin.x = SelectedViewXForBtn(toItemButton)-10;
            frame.size.width = ButtonLabelWidth(toItemButton)+20;
        } else {
            frame.origin.x = SelectedViewXForBtn(toItemButton);
            frame.size.width = SelectedViewWidthForBtn(toItemButton);
        }
        
        _selectedView.frame = frame;
        
        [self scrollToSelectedIndex]; //滚动并显示滑块视图
        [self p_updateRedDotOnButton:toItemButton];//消除频道右上角小红点 lijian 2017-08-31
    } else if (ABS(_selectedIndex - toIndex) > 1) { //选中项切换不连续，执行移动动画，忽略进度参数
        //菜单项
        UIColor *toColor = (_itemButtons.count > 1) ? _selectedColor : _unselectedColor; //只有一个菜单项时无选中状态
        [toItemButton setTitleColor:toColor forState:UIControlStateNormal];
        [fromItemButton setTitleColor:_unselectedColor forState:UIControlStateNormal];
        fromItemButton.titleLabel.font = [self p_normalFont];
        toItemButton.titleLabel.font = [self p_selectedFont];
        
        //滑块
        CGRect frame = _selectedView.frame;
        if (self.themeType == CYPageMenuThemeTypeSec) {
            frame.origin.x = SelectedViewXForBtn(toItemButton)-10;
            frame.size.width = ButtonLabelWidth(toItemButton)+20;

        } else {
            frame.origin.x = SelectedViewXForBtn(toItemButton);
            frame.size.width = SelectedViewWidthForBtn(toItemButton);
        }
        
        
        
        [UIView animateWithDuration:0.2 animations:^{
            _selectedView.frame = frame;
            [self scrollToSelectedIndex]; //滚动并显示滑块视图
            [self p_updateRedDotOnButton:toItemButton];//消除频道右上角小红点 lijian 2017-08-31
        }];
    } else { //选中项切换连续，按进度更新视图
        //选中项过渡色
        UIColor *fromColor, *toColor;
        CGFloat selR, selG, selB, selA, unsR, unsG, unsB, unsA;
        
        //注：应保证颜色值由 +colorWithRed:green:blue:alpha: 方法创建（而非 +colorWithWhite:alpha: 等方法）。否则在iOS7上 -getRed:green:blue:alpha: 无法成功取色。
        if ([_selectedColor getRed:&selR green:&selG blue:&selB alpha:&selA] && [_unselectedColor getRed:&unsR green:&unsG blue:&unsB alpha:&unsA]) {
            fromColor = [UIColor colorWithRed:unsR * progress + selR * (1 - progress)
                                        green:unsG * progress + selG * (1 - progress)
                                         blue:unsB * progress + selB * (1 - progress)
                                        alpha:unsA * progress + selA * (1 - progress)];
            toColor = [UIColor colorWithRed:selR * progress + unsR * (1 - progress)
                                      green:selG * progress + unsG * (1 - progress)
                                       blue:selB * progress + unsB * (1 - progress)
                                      alpha:selA * progress + unsA * (1 - progress)];
        } else {
            fromColor = _unselectedColor;
            toColor = _selectedColor;
        }
        
        [fromItemButton setTitleColor:fromColor forState:UIControlStateNormal];
        [toItemButton setTitleColor:toColor forState:UIControlStateNormal];
        
        
        //滑块动画
        CGFloat fromMidX = round(CGRectGetMidX(fromItemButton.frame));
        CGFloat fromMinX = ButtonLabelX(fromItemButton);
        if (self.themeType == CYPageMenuThemeTypeSec) {
            fromMinX -= 10;
        }
        
        CGFloat toMidX = round(CGRectGetMidX(toItemButton.frame));
        CGFloat toMinX = ButtonLabelX(toItemButton);
        if (self.themeType == CYPageMenuThemeTypeSec) {
            toMinX -= 10;
        }
        
        CGFloat fromX = 0.0;
        CGFloat fromW = 0.0;
        CGFloat fromP = 0.0;
        CGFloat toX = 0.0;
        CGFloat toW = 0.0;
        CGFloat toP = 0.0;
        
        CGRect frame = _selectedView.frame;
        if (progress <= 0.5) { //动画前半段
            fromX = fromMinX;
            toX = MIN(fromMidX, toMidX);
            
            fromW = SelectedViewWidthForBtn(fromItemButton);
            if (self.themeType == CYPageMenuThemeTypeSec) {
                fromW = ButtonLabelWidth(fromItemButton)+20;
            }
            toW = ABS(toMidX - fromMidX);
            
            fromP = 1.0 - progress * 2.0;
            toP = progress * 2.0;
        } else { //动画后半段
            fromX = MIN(fromMidX, toMidX);
            toX = toMinX;
            
            fromW = ABS(toMidX - fromMidX);

            toW = SelectedViewWidthForBtn(toItemButton);
            if (self.themeType == CYPageMenuThemeTypeSec) {
                toW = ButtonLabelWidth(toItemButton)+20;
            }
            
            fromP = 2.0 - progress * 2.0;
            toP = progress * 2.0 - 1.0;
        }
        frame.origin.x = fromX * fromP + toX * toP; //表达式：随着进度增加，从from匀速向to转换
        frame.size.width = fromW * fromP + toW * toP;
        

        if (progress >= 0.999) { //完成切换
            [UIView animateWithDuration:0.2 animations:^{
                _selectedView.frame = frame;
                fromItemButton.titleLabel.font = [self p_normalFont];
                toItemButton.titleLabel.font = [self p_selectedFont];

                [self scrollToSelectedIndex]; //滚动并显示滑块视图
                [self p_updateRedDotOnButton:toItemButton];//消除频道右上角小红点 lijian 2017-08-31
            }];
        } else { //正在切换
            _selectedView.frame = frame;
        }
    }
}

#pragma mark-private

-(CGFloat) p_fontSize {
    return [self.delegate fontSizeForHomeMenu];
}

- (CGFloat) p_selectedFontSize
{
    return [self.delegate fontSizeForSelectMenu];
}

- (UIFont *) p_normalFont
{
    return [self.delegate normalFont];
}

- (UIFont *) p_selectedFont
{
    return [self.delegate selectedFont];
}

-(CGFloat) p_padding {
    if (self.levelType == CYPageMenuLevelFirst) {
        return kPaddingItemBig;
    } else {
        return [self p_paddingItem];
    }
}

-(CGFloat) p_paddingItem {
    return (CY_IsiPhone6P ? 13 : 14.5);
}

////消除频道右上角小红点 lijian 2017-08-31
- (void)p_updateRedDotOnButton:(UIButton *)toItemButton {
    if (toItemButton && [toItemButton subviews]) {
        for (UIView *subView in [toItemButton subviews]) {
            if (subView.tag == RedDotSignChannelTag) {
                subView.hidden = YES;
            }
        }
    }
}

-(void) p_setupMenuItem {
    CGFloat maxX = ceil(self.padding.left);
    CGRect frame = CGRectZero;
    frame.origin.y = 0.0;
    frame.size.height = kItemHeight;
    
    for (NSInteger i = 0; i < self.menuItems.count; i++) {
        CYPageMenuItem *menuItem = self.menuItems[i];
        CYPageMenuButton *itemButton = nil;//UIButton *itemButton = nil; 用自定义button，方便设置小红点
        if (i < self.itemButtons.count) {
            itemButton = self.itemButtons[i];
        } else {
            itemButton = [[CYPageMenuButton alloc] init];
            itemButton.exclusiveTouch = YES;
            [itemButton addTarget:self action:@selector(p_touchItemAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.itemButtons addObject:itemButton];
        }
        
        itemButton.titleLabel.font = [self p_normalFont];

        // 更新标题
        itemButton.tag = i;
        [itemButton setTitle:menuItem.title forState:UIControlStateNormal];
        [itemButton setTitleColor:self.unselectedColor forState:UIControlStateNormal];
        
        [self.scrollView addSubview:itemButton];
        
        // 更新frame
        CGSize titleSize = [itemButton.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        frame.origin.x = round(maxX);
        
        CGFloat tPadding = [self p_padding];
        frame.size.width = ceil(titleSize.width + tPadding * 2);
        itemButton.frame = frame;
        
        maxX += CGRectGetWidth(itemButton.frame);

        
        for (UIView *subView in itemButton.subviews) {
            if (subView.tag == RedDotSignChannelTag) {
                [subView removeFromSuperview];
            }
        }
        
        UIImageView *redDotSignChannel = [self redDotSignChannel];
        [itemButton addSubview:redDotSignChannel];
        //lijian 2017-08-22 对reddot进行相对布局(masonry)
        [redDotSignChannel mas_makeConstraints:(^(MASConstraintMaker *make){
            make.top.mas_equalTo(itemButton.mas_top).offset(11);
            make.right.mas_equalTo(itemButton.mas_right).offset(-3);
            make.width.equalTo(@10);
            make.height.equalTo(@10);
        })];
        redDotSignChannel.hidden = YES;
        redDotSignChannel.tag =  RedDotSignChannelTag;//添加tag值
        
        if (menuItem.is_red_dot) {
            redDotSignChannel.hidden = NO;
        }
    }
    
    // 容器视图
    CGFloat menuWidth = round(CGRectGetWidth(self.frame));
    CGFloat menuHeight = round(CGRectGetHeight(self.frame));
    CGFloat contentWidth = round(maxX + self.padding.right);
    CGFloat contentHeight = kItemHeight;
    
    frame.origin.y = menuHeight - contentHeight;
    frame.size.height = contentHeight;
    // 内容宽度没有超出视图，左对齐
    if (contentWidth <= menuWidth) {
        // 默认左对齐
        if (self.contentMode == UIViewContentModeLeft) {
            frame.origin.x = 0.0;
            frame.size.width = contentWidth;
            self.scrollView.frame = frame;
            self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        } else {
            frame.origin.x = ceil(menuWidth / 2.0 - contentWidth / 2.0);
            frame.size.width = contentWidth;
            self.scrollView.frame = frame;
            self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        }
        self.scrollView.scrollEnabled = NO;
    } else {
        frame.origin.x = 0.0;
        frame.size.width = menuWidth;
        self.scrollView.frame = frame;
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        self.scrollView.scrollEnabled = YES;
    }
    
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    
    // 滑块视图
    if (self.itemButtons.count > 0) {
        frame = self.selectedView.frame;
        UIButton *firstButton = [self.itemButtons firstObject];
        // 强制layout firstButton，否则获取不到titleLabel的frame
        [firstButton setNeedsLayout];
        [firstButton layoutIfNeeded];
        
        frame.origin.y = CGRectGetHeight(self.scrollView.frame) - CGRectGetHeight(frame) - 12.5;
        if (self.themeType == CYPageMenuThemeTypeSec) {
            frame.origin.y = ButtonLabelY(firstButton)-2.5;
        }
        
        frame.size.width = SelectedViewWidthForBtn(firstButton);
        frame.origin.x = SelectedViewXForBtn(firstButton);
        
        self.selectedView.frame = frame;
        self.selectedView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;

    }
    
    self.selectedView.hidden = (self.menuItems.count <= 0);
    self.backgroundColor = [UIColor clearColor];
}

-(void) p_touchItemAction:(UIButton *)sender {
    NSInteger index = sender.tag;
    CYPageMenuItem *item = (index < self.menuItems.count) ? self.menuItems[index] : nil;
    if ([self.delegate respondsToSelector:@selector(homeMenu:willSelectMenuItem:atIndex:)]) {
        [self.delegate homeMenu:self willSelectMenuItem:item atIndex:index];
    }
    
    [self updateSelectedIndex:index];
    
    if ([self.delegate respondsToSelector:@selector(homeMenu:didSelectMenuItem:atIndex:)]) {
        [self.delegate homeMenu:self didSelectMenuItem:item atIndex:index];
    }
    
    //消除频道右上角小红点 lijian 2017-08-30
    for (UIView *subView in [sender subviews]) {
        if (subView.tag == RedDotSignChannelTag) {
            subView.hidden = YES;
        }
    }
}

//lijian 2017-08-22 小红点
- (UIImageView *) redDotSignChannel {
    UIImageView *redDotSignChannel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userspace_reddot"]];//[[UIView alloc] init];
    redDotSignChannel.contentMode = UIViewContentModeScaleAspectFill;
    redDotSignChannel.frame = CGRectMake(74/2, (98-69)/2, 10, 10);
//    redDotSignChannel.backgroundColor = [UIColor colorWithHexRGB:@"#FF0606"];
//    redDotSignChannel.layer.cornerRadius = 3;
//    redDotSignChannel.layer.masksToBounds = YES;
//    redDotSignChannel.userInteractionEnabled = NO;
    
    return redDotSignChannel;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.leftGradientImageView.frame = CGRectMake(-12, 0, kGradientImageWidth, CGRectGetHeight(self.bounds));
    self.rightGradientImageView.frame = CGRectMake(CGRectGetWidth(self.bounds)-kGradientImageWidth+12, 0, kGradientImageWidth, CGRectGetHeight(self.bounds));
}

@end


@implementation UIViewController (CYPageMenu)

-(CYPageMenuItem *) menuItem {
    return objc_getAssociatedObject(self, @selector(menuItem));
}

-(void) setMenuItem:(CYPageMenuItem *)menuItem {
    objc_setAssociatedObject(self, @selector(menuItem), menuItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CYPageMenu *)menu {
    return objc_getAssociatedObject(self, @selector(menu));
}

-(void) setMenu:(CYPageMenu *)menu {
    objc_setAssociatedObject(self, @selector(menu), menu, OBJC_ASSOCIATION_ASSIGN);
}

@end



































