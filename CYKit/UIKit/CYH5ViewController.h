//
//  CYH5ViewController.h
//  CYKit
//
//  Created by 成焱 on 2019/8/30.
//

#import "CYBaseViewController.h"

static NSString * _Nullable const k_DidRegisteSuccessNotification = @"k_DidRegisteSuccessNotification";

typedef void(^JSBlock)(NSString *jsName);

NS_ASSUME_NONNULL_BEGIN

@interface CYH5ViewController : CYBaseViewController

- (instancetype) initWithURL:(NSURL *)url;

- (void) registeWithName:(NSString *)jsName
           completeBlock:(JSBlock)block;

@end

NS_ASSUME_NONNULL_END
