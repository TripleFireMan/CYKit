//
//  UIImage+CYAddtion.m
//  CYKit
//
//  Created by 成焱 on 2017/2/19.
//  Copyright © 2017年 chengyan. All rights reserved.
//

#import "UIImage+CYAddtion.h"

@implementation UIImage (CYAddtion)
+ (instancetype)cy_imageByPureColor:(UIColor *)color size:(CGSize)size
{
    NSAssert(color, @"cannot create a pure color with a nil object");
    
    @autoreleasepool {
        CGRect imageRect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, imageRect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

- (instancetype)cy_imageScaleToSize:(CGSize)size
{
    if (CGSizeEqualToSize(CGSizeZero, size)) {
        return self;
    }
    
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (instancetype)cy_imageScaleByFactor:(CGFloat)factor
{
    if (factor <= 0) {
        return self;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * factor, self.size.height * factor));
    [self drawInRect:CGRectMake(0, 0, self.size.width * factor, self.size.height * factor)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
