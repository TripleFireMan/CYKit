//
//  SYFeedBackViewController.h
//  SuoYi
//
//  Created by 成焱 on 2019/8/27.
//  Copyright © 2019 sy. All rights reserved.
//

#import "CYBaseViewController.h"
#import "CYKitDefines.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const k_CYTextFeedBackKey = @"k_CYTextFeedBackKey";
static NSString * const k_CYPicUrlFeedBackKey = @"k_CYPicUrlFeedBackKey";
static NSString * const k_CYMobilePhoneKey = @"k_CYMobilePhoneKey";

@interface CYFeedBackViewController : CYBaseViewController

@property (nonatomic, copy) CYImageBlock uploadImageBlock;
@property (nonatomic, copy) CYDictionaryBlock confirmBlock;
@property (nonatomic, copy) NSString *picUrl;
@end

NS_ASSUME_NONNULL_END
