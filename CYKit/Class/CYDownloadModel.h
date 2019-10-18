//
//  CYDownloadModel.h
//  CYKit
//
//  Created by 成焱 on 2019/10/14.
//  支持自定义下载文件夹目录

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CYDownloadProgress;

typedef NS_ENUM(NSInteger, CYDownloadStatus){
    CYDownload_Init,//初始状态
    CYDownload_Wait,//等待下载
    CYDownload_Downloading,//正在下载
    CYDownload_Pause,//暂停
    CYDownload_Cancel,//取消
    CYDownload_Downloaded,//下载完成
    CYDownload_Failed,//下载失败
};

typedef void(^CYDownloadProgessBlock)(CYDownloadProgress *progress);
typedef void(^CYDownloadStateBlock)(CYDownloadStatus status, NSString *filePath, NSError *error);

@interface CYDownloadModel : NSObject
/// 下载地址
@property (nonatomic, copy  ) NSString *downloadUrl;
/// 下载文件夹路径
@property (nonatomic, copy  ) NSString *downloadDirectory;
/// 文件名
@property (nonatomic, copy  ) NSString *fileName;
/// 目标文件夹路径
@property (nonatomic, copy  ) NSString *destinationFilePath;

/// 下载状态
@property (nonatomic, assign) CYDownloadStatus state;
/// 下载任务
@property (nonatomic, strong) NSURLSessionDownloadTask *task;
/// 时间戳
@property (nonatomic, strong) NSDate *downloadDate;
/// 进度回调
@property (nonatomic, copy  ) CYDownloadProgessBlock progressBlock;
/// 状态回调
@property (nonatomic, copy  ) CYDownloadStateBlock  stateBlock;
/// 下载进度
@property (nonatomic, strong) CYDownloadProgress *progrss;  //下载进度

- (instancetype) initWithURL:(NSString *)url;
- (instancetype) initWithURL:(NSString *)url destinationFilePath:(nullable NSString *)destinationPath NS_DESIGNATED_INITIALIZER;
- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;
- (NSString *)stateDescription;
@end


@interface CYDownloadProgress : NSObject
/// 续传大小
@property (nonatomic, assign) int64_t resumeBytesWritten;
/// 当次写入大小
@property (nonatomic, assign) int64_t bytesWritten;
/// 已下载大小
@property (nonatomic, assign) int64_t totalBytesWritten;
/// 总文件大小
@property (nonatomic, assign) int64_t totalBytesExpectWritten;
/// 速度
@property (nonatomic, assign) float speed;
/// 进度
@property (nonatomic, assign) float progress;
/// 剩余时间
@property (nonatomic, assign) int remainingTime;
/*
 http://v3-default.ixigua.com/1b84bb86e397763e7736c58916a9258e/5da6e8b5/video/m/2205c26c31388ba4c5eb47e71389cc753991163b74d20000937a218f89c0/?a=1217&br=385&cr=0&cs=0&dr=0&ds=2&er=&l=2019101616502801001404707504086A16&lr=&rc=M2Y5NDM0aWxscDMzNzczM0ApZzs0Zmg0ZTs5N2k0aTk1Z2cuYWhjazMwZWFfLS0zLTBzc2BgY19gYS5hNDUyMS8wYmE6Yw%3D%3D
 */
@end

NS_ASSUME_NONNULL_END
