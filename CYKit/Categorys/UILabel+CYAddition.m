//
//  UILabel+CYAddition.m
//  AFNetworking
//
//  Created by 成焱 on 2019/12/20.
//

#import "UILabel+CYAddition.h"
#import "CYKitDefines.h"

@implementation UILabel (CYAddition)
+ (UILabel *) cy_labelWithFont:(UIFont *)font color:(UIColor *)color ali:(NSTextAlignment)ali text:(NSString *)text
{
    UILabel *label = [UILabel new];
    label.font = font?font:CYPingFangSCRegular(15);
    label.textColor = color?:[UIColor blackColor];
    label.textAlignment = ali;
    label.text = text;
    return label;
}
@end
