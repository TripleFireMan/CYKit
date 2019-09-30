//
//  SYHelpUsModel.h
//  SuoYi
//
//  Created by 成焱 on 2019/8/7.
//  Copyright © 2019 sy. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class SYHelpUsSubModel;
@interface SYHelpUsModel : NSObject<YYModel>
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *Pic_Url;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSArray <SYHelpUsSubModel *> * children;
@property (nonatomic, assign) BOOL isSeleted;
@end

@interface SYHelpUsSubModel : NSObject<YYModel>
@property (nonatomic, copy) NSString *Author;
@property (nonatomic, copy) NSString *CreateDate;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *PicUrl;
@property (nonatomic, copy) NSString *Title;
@end

NS_ASSUME_NONNULL_END
