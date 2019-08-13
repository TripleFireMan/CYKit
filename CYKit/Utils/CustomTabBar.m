//
//  CustomTabBar.m
//  CustomTabBarDemo
//
//  Created by chengyan on 17/2/21.
//  Copyright © 2017年 Youku.inc. All rights reserved.
//

#import "CustomTabBar.h"
static int Tag = 10;
const  int customTabBarTagOffset = 10;
const  int centerTag = 100;

@interface CustomTabBar ()
@property (nonatomic, strong) UIView *line;
@end


@implementation CustomTabBar
@synthesize selectedIndex = _selectedIndex;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.backgroundColor = [UIColor whiteColor];
        self.selectedIndex = 0;
//        self.line = [UIView new];
//        self.line.backgroundColor = [UIColor colorWithHexRGB:@"#ececec"];
//        [self addSubview:self.line];
//        CGFloat toplineHeight = 0.5f;
//        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.with.offset(0);
//            make.height.offset(toplineHeight);
//        }];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setFrameWithCenter];
}

- (void)setFrameWithCenter
{
    
    CGFloat toplineHeight = 0.5f;
    
    CGFloat tabBarWidth = self.frame.size.width;
    CGFloat tabBarHeight = self.frame.size.height;
    NSInteger buttonCount = Tag - customTabBarTagOffset;
    
    
    CGFloat centerWidth = self.centerView.frame.size.width;
    CGFloat centerHeight = self.centerView.frame.size.height - toplineHeight;
    CGFloat centerX = (tabBarWidth - centerWidth) / 2.f;
    CGFloat centerY;
    if (centerHeight <= tabBarHeight) {
        centerY = (tabBarHeight - centerHeight) / 2.f;
    }else{
        centerY = tabBarHeight - centerHeight;
    }
    
    self.centerView.frame = CGRectMake(centerX, centerY, centerWidth, centerHeight);
    
    CGFloat buttonY = toplineHeight;
    CGFloat buttonHeight = self.frame.size.height - toplineHeight;
    CGFloat buttonWidth = (float)(tabBarWidth - centerWidth)/ buttonCount;
    CGFloat buttonX;
    
    int i = 0;
    
    for (UIView *cosView  in self.subviews) {
        if (cosView.tag >= customTabBarTagOffset && cosView.tag < centerTag) {
            CustomBarButton *button = (CustomBarButton *)cosView;
            if (i < buttonCount / 2) {
                buttonX = i * buttonWidth;
            }else{
                buttonX = i * buttonWidth + centerWidth;
            }
            
            button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
            
            if (button.tag - customTabBarTagOffset == self.selectedIndex) {
                button.isSelected = YES;
            }
            
            i ++;
        }
    }
    
}

- (void)setCenterView:(UIView *)centerView
{
    _centerView = centerView;
    
    UIView *view = [self viewWithTag:centerTag];
    if (view) {
        [view removeFromSuperview];
    }
    _centerView.tag = centerTag;
    
    
    [self addSubview:_centerView];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    CustomBarButton *preButton = [self viewWithTag:_selectedIndex + customTabBarTagOffset];
    CustomBarButton *curButton = [self viewWithTag:selectedIndex + customTabBarTagOffset];
    
    preButton.isSelected = NO;
    curButton.isSelected = YES;
    
    _selectedIndex = selectedIndex;
    
    if (self.delegateed && [self.delegateed respondsToSelector:@selector(changeControllerWithIndex:)]) {
        [self.delegateed changeControllerWithIndex:_selectedIndex];
    }
    
}

- (void)addChildTabBarButton:(UITabBarItem *)item
{
    CustomBarButton *button = [[CustomBarButton alloc]initWithFrame:CGRectMake(10, 0, 45, 45)
                                                               item:item
                                                      selectedColor:[UIColor colorWithRed:255.f/255.f green:153.f/255.f blue:68.f/255.f alpha:1]
                                                        normalColor:[UIColor colorWithRed:153.f/255.f green:153.f/255.f blue:153.f/255.f alpha:1]];
    [button addTarget:self action:@selector(handleButtonAction:)];
    button.tag = Tag;
    Tag ++;
    
    NSLog(@"Tag = %d",Tag);
    [self addSubview:button];
}

- (void)addChildTabBarButton:(UITabBarItem *)item color:(UIColor *)color selectedColor:(UIColor *)selectedColor
{
    CustomBarButton *button = [[CustomBarButton alloc]initWithFrame:CGRectMake(10, 0, 45, 45)
                                                               item:item
                                                      selectedColor:selectedColor
                                                        normalColor:color];
    
    [button addTarget:self action:@selector(handleButtonAction:)];
    button.tag = Tag;
    Tag ++;
    
    NSLog(@"Tag = %d",Tag);
    [self addSubview:button];
}

- (void)handleButtonAction:(UIButton *)button
{
    self.selectedIndex = button.tag - customTabBarTagOffset;
}

- (CustomBarButton *)barButtonAtIndex:(NSInteger)index
{
    CustomBarButton *barButton = [self viewWithTag:customTabBarTagOffset + index];
    
    return barButton;
}

- (void)setTabBarButton:(CustomBarButton *)barButton title:(NSString *)title animated:(BOOL)animated
{
    [barButton  setTitle:title animated:animated];
}

@end
