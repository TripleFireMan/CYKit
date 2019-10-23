//
//  UIView+CYAddition.h
//  CYKit
//
//  Created by 成焱 on 2019/9/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CYAddition)
@property (nonatomic, strong, nullable) UIImageView *cy_errorImageView;
+ (id  ) cy_loadCurrentViewFromNib;
- (void) cy_showEmptyImage:(NSString *)name clickRefresh:(void(^)(void))complete;
- (void) cy_hideImages;
/// 做圆角
- (void) cy_cornerRound:(UIRectCorner)corner size:(CGSize)size;
/// ios13darkmode适配
- (void) cy_adjustForIOS13;
/// 渐变
- (void) cy_gradientLayerWithColor:(UIColor *)fromColor toColor:(UIColor *)toColor Horizontal:(BOOL)isHorizontal;

@end

NS_ASSUME_NONNULL_END
