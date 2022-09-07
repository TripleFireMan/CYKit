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

static inline UIFont * CYPingFangRegular(float size){
    return  [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}

static inline UIFont * CYPingFangMedium(float size){
    return  [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}
static inline UIFont * CYPingFangBold(float size){
    return  [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}

static inline UIColor * kRouteLineThemeColor(){
    return [UIColor cy_colorWithHexRGBString:@"006DE7"];
}


static inline UIColor * kTitleColor(){
    return [UIColor cy_colorWithHexRGBString:@"#333333"];
}

static inline UIColor * kSubtitleColor(){
    return [UIColor cy_colorWithHexRGBString:@"#666666"];
}

static inline UIColor * kSummaryColor(){
    return [UIColor cy_colorWithHexRGBString:@"#999999"];
}

static inline UIColor * kDetailColor(){
    return [UIColor cy_colorWithHexRGBString:@"#222222"];
}

static inline UIColor * kLineColor(){
    return  [UIColor cy_colorWithHexRGBString:@"#f5f5f5"];
}
