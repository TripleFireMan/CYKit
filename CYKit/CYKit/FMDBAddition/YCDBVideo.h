//
//  YCDBVideo.h
//  Youcai4iPhoneFramework
//
//  Created by chengyan on 2018/1/4.
//  Copyright © 2018年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCDBModel.h"

@interface YCDBVideo : NSObject<YCDBModel>

/// 视频名称
@property (nonatomic, copy) NSString *videoName;
/// 视频id
@property (nonatomic, copy) NSString *videoId;
/// 视频作者
@property (nonatomic, copy) NSString *author;
@end
