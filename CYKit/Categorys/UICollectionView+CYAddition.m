//
//  UICollectionView+CYAddition.m
//  CYKit
//
//  Created by 成焱 on 2019/12/19.
//

#import "UICollectionView+CYAddition.h"
@implementation UICollectionView (CYAddition)
- (void) cy_adjustForIOS11
{
    if (@available(iOS 11, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
    
    }
}
- (void) cy_adjustForIOS13
{
    [self cy_adjustForIOS11];
    if (@available(iOS 13, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        
    }
}
@end
