//
//  GJPictureUploadView.h
//  XingJiGuanJia
//
//  Created by 成焱 on 2019/12/18.
//  Copyright © 2019 cheng.yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYKitDefines.h"
NS_ASSUME_NONNULL_BEGIN

@interface CYPictureUploadView : UIView
@property (nonatomic, copy) CYVoidBlock uploadPicBlock;
@property (nonatomic, copy) CYNumberBlock deleteBlock;
@property (nonatomic, assign, readonly) NSInteger maxPicCount;
- (void) configModel:(id)model;
@end

NS_ASSUME_NONNULL_END
