//
//  UIImage+CYAddtion.h
//  CYKit
//
//  Created by 成焱 on 2017/2/19.
//  Copyright © 2017年 chengyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CYAddtion)


///-------------------------------------------
/// @name colors
///-------------------------------------------

/**
 create a pure color image with specialed color and size

 @param color the specialed color,cannot been nil
 @param size the specialed size,default is CGSizeZero
 @return a image with user assigned color and size
 */
+ (instancetype)cy_imageByPureColor:(UIColor *)color size:(CGSize)size;

///-------------------------------------------
/// @name scales
///-------------------------------------------

/**
 scale current image to destination size

 @param size destination size
 @return sized image
 */
- (instancetype)cy_imageScaleToSize:(CGSize)size;

/**
 scale current image with a specialed factor

 @param factor scaled factor, must larger than 0
 @return scaled image
 */
- (instancetype)cy_imageScaleByFactor:(CGFloat)factor;

// 图片置灰
- (void)grayscaleImageForImage:(UIImage *)image
                      complete:(void(^)(UIImage *complete))complete;
@end
