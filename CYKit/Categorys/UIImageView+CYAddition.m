//
//  UIImageView+CYAddition.m
//  CYKit
//
//  Created by 成焱 on 2019/9/2.
//

#import "UIImageView+CYAddition.h"
#import <YYKit/UIImageView+YYWebImage.h>
@implementation UIImageView (CYAddition)
- (void) cy_DownloadImage:(NSString *)url placeHolder:(NSString *)placeHolder
{
    [self setImageWithURL:[NSURL URLWithString:url] placeholder:[UIImage imageNamed:placeHolder]];
}

- (void) cy_DownloadImage:(NSString *)url placeHolder:(NSString *)placeHolder success:(CYImageBlock)success failure:(CYFailureBlock)block
{
    [self setImageWithURL:[NSURL URLWithString:url]
              placeholder:[UIImage imageNamed:placeHolder] options:YYWebImageOptionAllowInvalidSSLCertificates
               completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                   if (stage == YYWebImageStageFinished) {
                       if (!error) {
                           if (success) {
                               success(image);
                           }
                       }
                       else{
                           if (block) {
                               block(error,image);
                           }
                       }
                   }
               }];
}
@end








