//
//  TDHomeScrollView.m
//  Tudou4iPhone
//
//  Created by lijun on 17/1/25.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "CYPageScrollView.h"

@implementation CYPageScrollView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = YES;
        self.bounces = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;
        
        self.canCancelContentTouches = YES;
        self.delaysContentTouches = NO;
        self.directionalLockEnabled = YES;
    }
    return self;
}

// 解决在uicontrol上面无法滑动scrollView的bug
- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.contentOffset.x <= 0) {
        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
            return YES;
        }
    }
    return NO;
}

@end
