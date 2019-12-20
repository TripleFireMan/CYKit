//
//  UILabel+CYAddition.h
//  AFNetworking
//
//  Created by 成焱 on 2019/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (CYAddition)

+ (UILabel *) cy_labelWithFont:(nullable UIFont *)font
                         color:(nullable UIColor *)color
                           ali:(NSTextAlignment)ali
                          text:(nullable NSString *)text;
@end

NS_ASSUME_NONNULL_END
