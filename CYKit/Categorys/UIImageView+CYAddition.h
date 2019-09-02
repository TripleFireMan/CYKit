//
//  UIImageView+CYAddition.h
//  CYKit
//
//  Created by 成焱 on 2019/9/2.
//

#import <UIKit/UIKit.h>
#import "CYKitDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CYAddition)

- (void)cy_DownloadImage:(NSString *)url
             placeHolder:(NSString *)placeHolder;

- (void)cy_DownloadImage:(NSString *)url
             placeHolder:(NSString *)placeHolder
                 success:(CYImageBlock)success
                 failure:(CYFailureBlock)block;

@end

NS_ASSUME_NONNULL_END
