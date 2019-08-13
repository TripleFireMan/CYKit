//
//  UIColor+CYAddition.m
//  Pods
//
//  Created by chengyan on 2017/8/31.
//
//

#import "UIColor+CYAddition.h"

@implementation UIColor (CYAddition)
+ (instancetype)cy_colorWithHexRGBString:(NSString *)hexRGBString
{
    NSString *formatString = [hexRGBString hasPrefix:@"#"] ? [hexRGBString substringFromIndex:1] : hexRGBString;
    if (formatString.length == 6 || formatString.length == 8) {
        unsigned int colorCode = 0;
        unsigned char redByte, greenByte, blueByte, alphaByte;
        
        NSScanner *scanner = [NSScanner scannerWithString:formatString];
        [scanner scanHexInt:&colorCode];
        
        if (formatString.length == 6) { //RGB
            alphaByte = 0xff;
        } else { //ARGB
            alphaByte = (unsigned char) (colorCode >> 24);
        }
        redByte     = (unsigned char) (colorCode >> 16);
        greenByte   = (unsigned char) (colorCode >> 8);
        blueByte    = (unsigned char) (colorCode);
        
        return [UIColor colorWithRed:(float)redByte/0xff green:(float)greenByte/0xff blue:(float)blueByte/0xff alpha:(float)alphaByte/0xff];
    }
    return [UIColor clearColor];
}

+ (instancetype)cy_randomColor
{
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}
@end
