//
//  SYArticleModel.h
//  SuoYi
//
//  Created by 成焱 on 2019/8/8.
//  Copyright © 2019 sy. All rights reserved.
//
/*
 Author = "";
 Content = "<style type=\"text/css\">img {width:100%}</style > <p>\U6d4b\U8bd5\U6d4b\U8bd5</p><p><img src=\"http://paytest.sooyie.cn/UploadFiles/image/201908/20190807164823_298.png\" title=\"RequestedDownloadsLargeCloudIcon.contrast-white_scale-400.png\" alt=\"RequestedDownloadsLargeCloudIcon.contrast-white_scale-400.png\"/></p>";
 CreateDate = "8/7/2019 11:44:56 AM";
 PicUrl = "http://paytest.sooyie.cn//UploadFiles/image/201908/20190807114448_6782.png";
 Title = "\U4f7f\U7528\U5e2e\U52a9\U6d4b\U8bd5";
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYArticleModel : NSObject<YYModel>
@property (nonatomic, strong) NSString *Author;
@property (nonatomic, strong) NSString *Content;
@property (nonatomic, strong) NSString *CreateDate;
@property (nonatomic, strong) NSString *PicUrl;
@property (nonatomic, strong) NSString *Title;
@end

NS_ASSUME_NONNULL_END
