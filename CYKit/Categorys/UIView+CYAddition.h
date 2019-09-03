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
@end

NS_ASSUME_NONNULL_END
