//
//  UITableView+CYAddition.h
//  CYKit
//
//  Created by 成焱 on 2019/10/23.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (CYAddition)

+ (UITableView *) cy_tableViewWithDelegate:(id)delegate;

- (void) cy_registeCellClass:(NSString *)classString;

/// 滚动适配
- (void) cy_adjustForIOS11;
/// 暗黑模式适配
- (void) cy_adjustForIOS13;
/// headerPadding适配
- (void) cy_adjustForIOS15;
@end

NS_ASSUME_NONNULL_END
