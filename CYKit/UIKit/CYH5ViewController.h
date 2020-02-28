//
//  CYH5ViewController.h
//  CYKit
//
//  Created by 成焱 on 2019/8/30.
//

#import "CYBaseViewController.h"

typedef void(^JSBlock)(NSString * _Nullable jsName);

NS_ASSUME_NONNULL_BEGIN

@interface CYH5ViewController : CYBaseViewController

@property (nonatomic, strong) NSString *urlString;

- (instancetype) initWithURL:(NSURL *)url;

- (void) registeWithName:(NSString *)jsName
           completeBlock:(JSBlock)block;

@end

NS_ASSUME_NONNULL_END
