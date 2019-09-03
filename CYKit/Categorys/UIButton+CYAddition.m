//
//  UIButton+CYAddition.m
//  CYKit
//
//  Created by 成焱 on 2019/9/3.
//

#import "UIButton+CYAddition.h"

@implementation UIButton (CYAddition)
- (void) cy_gradientLayerWithColor:(UIColor *)fromColor toColor:(UIColor *)toColor Horizontal:(BOOL)isHorizontal
{
    
    [[self.layer sublayers] enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAGradientLayer class]]) {
            *stop = YES;
            return;
        }
    }];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0 ,0,self.frame.size.width,self.frame.size.height);
    if (isHorizontal) {
        gl.startPoint = CGPointMake(1, 0);
        gl.endPoint = CGPointMake(0, 0);
    }
    else{
        gl.startPoint = CGPointMake(0.5, 1);
        gl.endPoint = CGPointMake(0.5, 0);
    }

    gl.colors = @[(__bridge id)fromColor.CGColor,(__bridge id)toColor.CGColor];
    gl.locations = @[@(0),@(1.0f)];
    [self.layer insertSublayer:gl atIndex:0];
}
@end
