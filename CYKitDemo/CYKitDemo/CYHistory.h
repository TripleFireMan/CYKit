//
//  CYHistory.h
//  CYKitDemo
//
//  Created by chengyan on 2018/1/9.
//  Copyright © 2018年 cheng.yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CYKit/YCDBModel.h>
@interface CYHistory : NSObject<YCDBModel>

@property (nonatomic, copy  ) NSString *name;
@property (nonatomic, copy  ) NSString *desc;
@property (nonatomic, assign) NSInteger time;

@end
