//
//  UIButton+CYAddition.h
//  CYKit
//
//  Created by 成焱 on 2019/9/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CYAddition)
- (void) cy_gradientLayerWithColor:(UIColor *)fromColor
                           toColor:(UIColor *)toColor
                        Horizontal:(BOOL)isHorizontal;
@end

NS_ASSUME_NONNULL_END
