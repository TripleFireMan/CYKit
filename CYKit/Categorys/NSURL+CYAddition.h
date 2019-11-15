//
//  NSURL+CYAddition.h
//  CYKit
//
//  Created by 成焱 on 2019/11/15.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (CYAddition)
/// 不要往icloud备份
- (BOOL) cy_addSkipToiCloud;
@end

NS_ASSUME_NONNULL_END
