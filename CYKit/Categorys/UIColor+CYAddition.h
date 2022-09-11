//
//  UIColor+CYAddition.h
//  Pods
//
//  Created by chengyan on 2017/8/31.
//
//

#import <UIKit/UIKit.h>
#import "CYKitDefines.h"
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

static inline UIColor *kBackGroungColor(){
    return [UIColor cy_colorWithHexRGBString:@"#F5F5F5"];
}


static inline UIColor * CYIOS13SystemBackgroundColor(){
    if (@available(iOS 13, *)) {
        UIColor *bgClor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return [UIColor whiteColor];
            }
            else{
                return [UIColor blackColor];
            }
        }];
        return bgClor;
    } else {
        return [UIColor whiteColor];
    }
}

static inline UIColor * CYIOS13BackgroundColor(){
    if (@available(iOS 13, *)) {
        UIColor *bgClor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return [UIColor whiteColor];
            }
            else{
                return RGBColor(24, 24,28);
            }
        }];
        return bgClor;
    } else {
        return [UIColor whiteColor];
    }
}

static inline UIColor * CYIOS13ContainerColor(){
    if (@available(iOS 13, *)) {
        UIColor *bgClor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return kBackGroungColor();
            }
            else{
                return RGBColor(44, 44, 44);
            }
        }];
        return bgClor;
    } else {
        return kBackGroungColor();
    }
}

static inline UIColor * CYIOS13LabelColor(){
    if (@available(iOS 13, *)) {
        return [UIColor labelColor];
    } else {
        return [UIColor blackColor];
    }
}

static inline UIColor * CYIOS13SecondLabelColor(){
    if (@available(iOS 13, *)) {
        return [UIColor secondaryLabelColor];
    } else {
        return RGBColor(120, 120, 120);
    }
}

static inline UIColor * CYIOS13PlaceholderTextColor(){
    if (@available(iOS 13, *)) {
        return [UIColor placeholderTextColor];
    } else {
        return RGBColor(192, 192, 192);
    }
}

static inline UIColor * CYIOS13BorderColor(){
    if (@available(iOS 13, *)) {
        UIColor *bgClor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return [UIColor cy_colorWithHexRGBString:@"#222222"];
            }
            else{
                return RGBColor(252, 252, 252);
            }
        }];
        return bgClor;
    } else {
        return [UIColor cy_colorWithHexRGBString:@"#222222"];
    }
}

static inline UIColor * CYIOS13LineColor(){
    if (@available(iOS 13, *)) {
        UIColor *bgClor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return kLineColor();
            }
            else{
                return RGBColor(252, 252, 252);
            }
        }];
        return bgClor;
    } else {
        return kLineColor();
    }
}

static inline float CYBottomSafeAreaHeight(){
    return  CY_Height_Bottom_SafeArea;
}

static inline float CYStatueBarHeight(){
    return  CY_Height_StatusBar;
}

static inline float CYNavigationBarHeight(){
    return  CY_Height_NavBar;
}

static inline float CYTabbarHeight(){
    return  CY_Height_TabBar;
}
