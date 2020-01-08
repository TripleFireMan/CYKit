//
//  UITableView+CYAddition.m
//  CYKit
//
//  Created by 成焱 on 2019/10/23.
//

#import "UITableView+CYAddition.h"
#import "UIScrollView+CYAddition.h"



@implementation UITableView (CYAddition)

+ (UITableView *) cy_tableViewWithDelegate:(id)delegate
{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    table.delegate = delegate;
    table.dataSource = delegate;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = [UIColor whiteColor];
    [table cy_adjustForIOS13];
    return table;
}

- (void) cy_registeCellClass:(NSString *)classString
{
    [self registerClass:NSClassFromString(classString) forCellReuseIdentifier:classString];
}
- (void) cy_adjustForIOS11
{
    if (@available(iOS 11, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
    } else {
    
    }
}

- (void) cy_adjustForIOS13
{
    [self cy_adjustForIOS11];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
    if (@available(iOS 13, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        
    }
#endif
}
@end
