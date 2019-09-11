//
//  TDHomeMenuItem.h
//  Tudou4iPhone
//
//  Created by lijun on 17/1/25.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPageMenuItem : NSObject
// 唯一标识
@property (nonatomic, copy) NSString *itemId;
// 标题
@property (nonatomic, copy) NSString *title;

/**
 * lijian 2017-08-22
 * 新加字段 可见频道红点是否显示
 */
@property (nonatomic, assign) BOOL is_red_dot;

@end
