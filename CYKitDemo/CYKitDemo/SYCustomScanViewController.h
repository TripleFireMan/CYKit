//
//  SYCustomScanViewController.h
//  SuoYi
//
//  Created by 成焱 on 2019/8/14.
//  Copyright © 2019 sy. All rights reserved.
//

#import "LBXScanViewController.h"
#import "StyleDIY.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SYCustomScanType){
    /// 收款
    SYCustomScanType_IncomeMoney,
    /// 绑卡
    SYCustomScanType_BindCard,
    /// 换卡
    SYCustomScanType_ChangeCard,
};

@interface SYCustomScanViewController : LBXScanViewController
@property (nonatomic, assign) double payMoney;


@property (nonatomic, assign) SYCustomScanType scanType;
@end

NS_ASSUME_NONNULL_END
