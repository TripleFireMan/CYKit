//
//  SYDebugViewController.h
//  SuoYi
//
//  Created by 成焱 on 2019/8/26.
//  Copyright © 2019 sy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYDebugModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SYDebugCellCallBack)(SYDebugModel *model);

@interface SYDebugViewController : UIViewController

@property (nonatomic, copy) SYDebugCellCallBack callBack;

@end

NS_ASSUME_NONNULL_END
