//
//  CustomTabBarController+Initional.m
//  CYKitDemo
//
//  Created by chengyan on 17/3/20.
//  Copyright © 2017年 cheng.yan. All rights reserved.
//

#import "CustomTabBarController+Initional.h"
#import "HomeViewController.h"
#import "MeViewController.h"

@implementation CustomTabBarController (Initional)

- (void)setUp
{
    HomeViewController *home    = [HomeViewController new];
    MeViewController   *me      = [MeViewController new];
    
    UINavigationController *homeNavi    = [[UINavigationController alloc]initWithRootViewController:home];
    UINavigationController *meNavi      = [[UINavigationController alloc]initWithRootViewController:me];
    
    [self addChildViewController:homeNavi title:@"首页" image:nil selectedImage:nil color:[UIColor grayColor] selectedColor:[UIColor redColor]];
    
    [self addChildViewController:meNavi title:@"我的" image:nil selectedImage:nil color:[UIColor grayColor] selectedColor:[UIColor redColor]];
}

@end
