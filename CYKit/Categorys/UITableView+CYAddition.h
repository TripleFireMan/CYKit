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

- (void) cy_adjustForIOS11;
- (void) cy_adjustForIOS13;
@end

NS_ASSUME_NONNULL_END
