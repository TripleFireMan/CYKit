//
//  UIScrollView+CYAddition.m
//  CYKit
//
//  Created by 成焱 on 2019/10/18.
//

#import "UIScrollView+CYAddition.h"

@implementation UIScrollView (CYAddition)
- (void) cy_adjustForIOS11
{
    if (@available(iOS 11, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
}
@end
