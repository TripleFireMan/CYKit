//
//  UIColor+CYAddition.h
//  Pods
//
//  Created by chengyan on 2017/8/31.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (CYAddition)

/**
 color with hex color string,eg.@"#FFFFFF"/@"FFFFFF",means whiteColor.

 @param hexRGBString hex color string,if nil, reture nil color
 @return get a color by hex string
 */
+ (instancetype)cy_colorWithHexRGBString:(NSString *)hexRGBString;

/**
 get a random color

 @return random color
 */
+ (instancetype)cy_randomColor;

@end
