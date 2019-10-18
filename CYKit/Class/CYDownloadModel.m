//
//  CYDownloadModel.m
//  CYKit
//
//  Created by 成焱 on 2019/10/14.
//

#import "CYDownloadModel.h"
#import "NSString+CYAddition.h"
@interface CYDownloadModel ()
@end

@implementation CYDownloadModel

- (instancetype) initWithURL:(NSString *)url
{

    return [self initWithURL:url destinationFilePath:nil];
}

- (instancetype) initWithURL:(NSString *)url destinationFilePath:(NSString *)destinationPath
{
    self = [super init];
    if (self) {
        self.downloadUrl = url;
        self.state = CYDownload_Init;
        self.downloadDirectory = destinationPath.stringByDeletingLastPathComponent;
        self.fileName = destinationPath.lastPathComponent;
        self.progrss = [[CYDownloadProgress alloc] init];
    }
    return self;
}

#pragma mark - Lazy
- (NSString *)downloadDirectory
{
    if (!_downloadDirectory) {
        _downloadDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"CYDownload"];
        
    }
    
    return _downloadDirectory;
}

- (NSString *)fileName
{
    if (!_fileName) {
        _fileName = [[[self.downloadUrl lastPathComponent] cy_md5String] stringByAppendingString:@".mp4"];
    }
    return _fileName;
}

- (NSString *)destinationFilePath
{
    if (!_destinationFilePath) {
        _destinationFilePath = [self.downloadDirectory stringByAppendingPathComponent:self.fileName];
    }
    return _destinationFilePath;
}

- (NSString *)stateDescription
{
    NSString *stateDes = nil;
    switch (self.state) {
        case CYDownload_Init:
        case CYDownload_Wait:
        {
            stateDes = @"等待下载";
        }
            break;
        case CYDownload_Downloading:
        {
            stateDes = @"下载中";
        }
            break;
        case CYDownload_Downloaded:
        {
            stateDes = @"下载完成";
        }
            break;
        case CYDownload_Pause:
        {
            stateDes = @"暂停下载";
        }
            break;
        case CYDownload_Cancel:
        {
            stateDes = @"取消下载";
        }
            break;
        case CYDownload_Failed:
        {
            stateDes = @"下载失败";
        }
            break;
        default:
            break;
    }
    return stateDes;
}
@end

@implementation CYDownloadProgress

- (NSString *)description{
    return [NSString stringWithFormat:@"当次下载大小：%@,已下载：%@，总大小：%@，速度：%@，剩余时间:%@,进度：%@",@(self.bytesWritten),@(self.totalBytesWritten),@(self.totalBytesExpectWritten),@(self.speed),@(self.remainingTime),@(self.progress)];
}

@end
