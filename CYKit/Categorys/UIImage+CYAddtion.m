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

- (void)grayscaleImageForImage:(UIImage *)image complete:(void(^)(UIImage *img)) complete {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        const int RED = 1;
        
        const int GREEN = 2;
        
        const int BLUE = 3;
        
        
        
        // Create image rectangle with current image width/height
        
        CGRect imageRect = CGRectMake(0, 0, image.size.width * image.scale, image.size.height * image.scale);
        
        
        
        int width = imageRect.size.width;
        
        int height = imageRect.size.height;
        
        
        
        // the pixels will be painted to this array
        
        uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
        
        
        
        // clear the pixels so any transparency is preserved
        
        memset(pixels, 0, width * height * sizeof(uint32_t));
        
        
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        
        
        // create a context with RGBA pixels
        
        CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                     
                                                     kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
        
        
        
        // paint the bitmap to our context which will fill in the pixels array
        
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), [image CGImage]);
        
        
        
        for(int y = 0; y < height; y++) {
            
            for(int x = 0; x < width; x++) {
                
                uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
                
                
                
                // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
                
                uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
                
                
                
                // set the pixels to gray
                
                rgbaPixel[RED] = gray;
                
                rgbaPixel[GREEN] = gray;
                
                rgbaPixel[BLUE] = gray;
                
            }
            
        }
        
        
        
        // create a new CGImageRef from our context with the modified pixels
        
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        
        
        
        // we're done with the context, color space, and pixels
        
        CGContextRelease(context);
        
        CGColorSpaceRelease(colorSpace);
        
        free(pixels);
        
        
        
        // make a new UIImage to return
        
        UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef
                                  
                                                     scale:image.scale
                                  
                                               orientation:UIImageOrientationUp];
        
        
        
        // we're done with image now too
        
        CGImageRelease(imageRef);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            complete?complete(resultUIImage):nil;
        });
    });
    
}

@end
