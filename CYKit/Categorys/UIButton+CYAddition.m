//
//  UIButton+CYAddition.m
//  CYKit
//
//  Created by 成焱 on 2019/9/3.
//

#import "UIButton+CYAddition.h"
#import "UIColor+CYAddition.h"
#import "UIImage+CYAddtion.h"
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

+ (UIButton *) buttonWithTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = CYPingFangMedium(16);
    btn.layer.cornerRadius = 22.f;
    btn.layer.masksToBounds = YES;
    
    [btn setTitleColor:[UIColor cy_colorWithHexRGBString:@"#242629"] forState:UIControlStateNormal];
    [btn setBackgroundImage: [UIImage cy_imageByPureColor:[UIColor cy_colorWithHexRGBString:@"#FFB000"] size:CGSizeZero] forState:UIControlStateNormal];
    [btn setBackgroundImage: [UIImage cy_imageByPureColor:[[UIColor cy_colorWithHexRGBString:@"#FFB000"] colorWithAlphaComponent:0.8] size:CGSizeZero] forState:UIControlStateHighlighted];
    return btn;
}
@end
