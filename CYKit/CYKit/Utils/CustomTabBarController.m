//
//  CustomTabBarController.m
//  CustomTabBarDemo
//
//  Created by chengyan on 17/2/21.
//  Copyright © 2017年 Youku.inc. All rights reserved.
//

#import "CustomTabBarController.h"

//#define TransformAnimation

@interface CustomTabBarController ()<CustomTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *listener;


@end

@implementation CustomTabBarController

+ (instancetype)shareInstance
{
    static CustomTabBarController *tabbarCtl = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabbarCtl = [[CustomTabBarController alloc]init];
    });
    return tabbarCtl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addListener:(id<CustomTabBarControllerDelegate>)listerner
{
    [self.listener addObject:listerner];
}

- (void)removeListener:(id<CustomTabBarControllerDelegate>)listener
{
    if ([self.listener containsObject:listener]) {
        [self.listener removeObject:listener];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    for (UIView *view in self.tabBar.subviews) {
        [view removeFromSuperview];
    }
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    self.tabBar.clipsToBounds = NO;
    [self.tabBar addSubview:self.customTabBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (CustomTabBar *)customTabBar
{
    if (!_customTabBar) {
        _customTabBar = [[CustomTabBar alloc]initWithFrame:CGRectZero];
        _customTabBar.frame = CGRectMake(0, -0.5, self.tabBar.frame.size.width, self.tabBar.frame.size.height + 0.5);
    }
    _customTabBar.delegateed = self;
    return _customTabBar;
}

- (NSMutableArray *)listener
{
    if (!_listener){
        _listener = @[].mutableCopy;
    }
    return _listener;
}

- (void)changeControllerWithIndex:(NSInteger)index
{
    BOOL theSame = self.selectedIndex == index;
    self.selectedIndex = index;
    
#ifdef TransformAnimation
    CATransition* animation = [CATransition animation];
    [animation setDuration:0.3f];
    [animation setType:kCATransitionFade];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [[self.view layer]addAnimation:animation forKey:@"switchView"];
#endif
    
    for (id <CustomTabBarControllerDelegate> listener in self.listener) {
        [listener customTabBarControllerDidSelectAtIndex:index customTabBar:self.customTabBar theSameToProAction:theSame];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    // 如果当前index与自定义的tabbar的index不同，重新设置下图片
    if (selectedIndex != self.customTabBar.selectedIndex) {
        
        // 只是为了换图片，因为个人中心消息页面有需求直接从第4个tab点击到第2个tab。这个时候，无法触发按钮换图功能
        CustomBarButton *preButton = [self.customTabBar viewWithTag:self.customTabBar.selectedIndex + customTabBarTagOffset];
        CustomBarButton *curButton = [self.customTabBar viewWithTag:selectedIndex + customTabBarTagOffset];
        
        preButton.isSelected = NO;
        curButton.isSelected = YES;
        
        self.customTabBar ->_selectedIndex = selectedIndex;
        
    }
}


- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage color:(UIColor *)color selectedColor:(UIColor *)selectedColor
{

    if ([childController isKindOfClass:[UINavigationController class]]) {
        UIViewController *top = [(UINavigationController *)childController topViewController];
        top.title = title;
    }
    
    childController.tabBarItem.title            = title;
    childController.tabBarItem.image            = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage    = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:childController];
    
    [self.customTabBar addChildTabBarButton:childController.tabBarItem color:color selectedColor:selectedColor];
}

- (void)setCustomTabBarButtonTitle:(NSString *)title
                             color:(UIColor *)color
                     selectedColor:(UIColor *)selectedColor
                             image:(UIImage *)image
                     selectedImage:(UIImage *)selectedImage
                             index:(NSInteger)index
{
    /// 刷新下自定义的按钮
    CustomBarButton *barButton = [self.customTabBar viewWithTag:customTabBarTagOffset + index];
    UITabBarItem *barItem = [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:selectedImage];
    [barButton setItem:barItem];
    [barButton setNormalColor:color];
    [barButton setSelectedColor:selectedColor];
    [barButton addTarget:self.customTabBar action:@selector(handleButtonAction:)];
    [barButton setNeedsLayout];
}

- (void)setTitle:(NSString *)title index:(NSInteger)index animation:(BOOL)animated
{
    CustomBarButton *barButton = [self.customTabBar viewWithTag:customTabBarTagOffset + index];
    [barButton setTitle:title animated:animated];
}

- (void)addCenterChildViewController:(UIViewController *)centerChildController  title:(NSString *)title view:(UIView *)centerView
{
    if ([centerChildController isKindOfClass:[UINavigationController class]]) {
        UIViewController *top = [(UINavigationController *)centerChildController topViewController];
        top.title = title;
    }
    
    [self addChildViewController:centerChildController];
    
    [self.customTabBar setCenterView:centerView];
}

- (NSString *)titleForIndex:(NSInteger)index
{
    if ([self.viewControllers count] > index) {
        CustomBarButton *barButton = [self.customTabBar viewWithTag:customTabBarTagOffset + index];
        return barButton.title;
    }else{
        return nil;
    }
}

- (BOOL)shouldAutorotate{
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return self.selectedViewController.supportedInterfaceOrientations;
}


@end
