//
//  SpeechD.m
//  NotificationService
//
//  Created by sy on 2019/7/29.
//  Copyright © 2019年 sy. All rights reserved.
//

#import "SpeechD.h"
#import <AVFoundation/AVFoundation.h>
@implementation SpeechD
+ (void)playPushNotifationVideo:(NSString *)str Type:(NSString *)type{
    dispatch_queue_t queue = dispatch_queue_create("readItNow", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSArray  *ResultArr  = [[SpeechD caculateNumber:str Type:type] mutableCopy];
        [SpeechD hecheng:ResultArr];
    });
}


+ (NSArray *)caculateNumber:(NSString *)primary Type:(NSString *)type
{
    long money = primary.doubleValue*10000000000/100000000;// 钱数 单位是(分)
    
    NSString *str = [NSString stringWithFormat:@"%ld",money];
    
    NSArray *temArr = @[@"", @"万", @"亿"];
    
    NSArray *arr = @[@"十", @"百", @"千"];
    
    NSMutableArray <NSString *>*lArr = [[NSMutableArray alloc] init];
    
    long preMoney = money / 100;
    
    if (money%10 == 0 && money%100 == 0) {
        //不用展示
    }else{
        [lArr addObject:@"点"];
        long lastMoney = money;
        [lArr insertObject:[NSString stringWithFormat:@"%ld",lastMoney%10] atIndex:1];
        lastMoney = lastMoney /10;
        [lArr insertObject:[NSString stringWithFormat:@"%ld",lastMoney%10] atIndex:1];
    }
    
    NSString *preMoneyStr = [NSString stringWithFormat:@"%ld",preMoney];
    
    for (int i=0; i<preMoneyStr.length; i++) {
        
        int a = preMoney % 10;
        preMoney = preMoney/10;
        
        NSString *strCon = @"";
        
        if(i%4 == 0){
            
            NSString *aStr = [NSString stringWithFormat:@"%d",a];
            strCon = [NSString stringWithFormat:@"%@%@",a==0?@"0":aStr,temArr[i/4]];
        }else{
            strCon = [NSString stringWithFormat:@"%d%@",a, a==0?@"0":arr[i%4-1]];
        }
        
        [lArr insertObject:strCon atIndex:0];
    }
    
    //删除重叠的0
    for (long i=lArr.count-1; i>0; i--) {
        if (([lArr[i] isEqualToString: lArr[i-1]] && [lArr[i] isEqualToString:@"0"]) || (lArr[i].length == 0)) {
            [lArr removeObjectAtIndex:i];
        }
    }
    if ([lArr containsObject:@"点"]||[lArr containsObject:@"万"]||[lArr containsObject:@"亿"]) {
        NSArray *tmpedArr = @[@"点",@"万",@"亿"];
        for (int i=0; i<3; i++) {
            
            if([lArr containsObject:tmpedArr[i]]){
                NSUInteger index = [lArr indexOfObject:tmpedArr[i]];
                if ([lArr[index - 1] isEqualToString:@"0"] && i==0 && index > 1) {
                    [lArr removeObjectAtIndex:index-1];
                }else if ([lArr[index - 1] isEqualToString:@"0"] && i!=0){
                    [lArr removeObjectAtIndex:index-1];
                }
            }
        }
    }else{
        if ([lArr.lastObject isEqualToString:@"0"]) {
            [lArr removeLastObject];
        }
    }
    [lArr addObject:@"元"];
    NSString *final = [lArr componentsJoinedByString:@""];
    
    NSLog(@"?????%@\n%@",str, final );
    NSMutableArray *finalArr;
    if ([type isEqualToString:@"支付宝"]) {
        finalArr = [[NSMutableArray alloc] initWithObjects:@"支付宝到账", nil];
    }else if ([type isEqualToString:@"微信"]){
        finalArr = [[NSMutableArray alloc] initWithObjects:@"微信到账", nil];
    }else{
        finalArr = [[NSMutableArray alloc] initWithObjects:@"云闪付到账", nil];
    }
    
    
    for (int i=0; i<final.length; i++) {
        [finalArr addObject:[final substringWithRange:NSMakeRange(i, 1)]];
    }
    return finalArr;
}




+ (void)hecheng:(NSArray *)fileNameArray{
    
    /************************合成音频并播放*****************************/
    NSMutableArray *audioAssetArray = [[NSMutableArray alloc] init];
    NSMutableArray *durationArray = [[NSMutableArray alloc] init];
    [durationArray addObject:@(0)];
    
    AVMutableComposition *composition = [AVMutableComposition composition];
    
    CMTime allTime = kCMTimeZero;
    
    for (NSInteger i = 0; i < fileNameArray.count; i++) {
        NSString *auidoPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",fileNameArray[i]] ofType:@"m4a"];
        AVURLAsset *audioAsset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:auidoPath]];
        [audioAssetArray addObject:audioAsset];
        
        
        // 音频轨道
        AVMutableCompositionTrack *audioTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
        
        // 音频素材轨道
        AVAssetTrack *audioAssetTrack = [[audioAsset tracksWithMediaType:AVMediaTypeAudio] firstObject];
        
        
        // 音频合并 - 插入音轨文件
        [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration) ofTrack:audioAssetTrack atTime:allTime error:nil];
        
        // 更新当前的位置
        allTime = CMTimeAdd(allTime, audioAsset.duration);
        
    }
    
    // 合并后的文件导出 - `presetName`要和之后的`session.outputFileType`相对应。
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setActive:YES error:nil];
//    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    

    
 
    
    NSString *outPutFilePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"test.m4a"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:outPutFilePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:outPutFilePath error:nil];
    }
    
    // 查看当前session支持的fileType类型
    AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:composition presetName:AVAssetExportPresetAppleM4A];
    NSLog(@"outPutFilePath---%@",outPutFilePath);
    NSLog(@"---%@",[session supportedFileTypes]);
    session.outputURL = [NSURL fileURLWithPath:outPutFilePath];
    session.outputFileType = AVFileTypeAppleM4A; //与上述的`present`相对应
    session.shouldOptimizeForNetworkUse = YES;   //优化网络
    
    [session exportAsynchronouslyWithCompletionHandler:^{
        
        NSLog(@"%@",[NSThread currentThread]);
        
        if (session.status == AVAssetExportSessionStatusCompleted) {
            NSLog(@"合并成功----%@", outPutFilePath);
            
            NSURL *url = [NSURL fileURLWithPath:outPutFilePath];
            
            static SystemSoundID soundID = 0;
            
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
            
            AudioServicesPlayAlertSoundWithCompletion(soundID, ^{
                NSLog(@"播放完成");
                AudioServicesDisposeSystemSoundID(soundID);
            });
            
        } else {
            // 其他情况, 具体请看这里`AVAssetExportSessionStatus`.
        }
    }];
}

+ (void)hechengPushMoney:(NSString *)money type:(NSString *)type complete:(void (^)(NSURL * _Nonnull))complete
{
    NSArray  *fileNameArray  = [[SpeechD caculateNumber:money Type:type] mutableCopy];
    /************************合成音频并播放*****************************/
    NSMutableArray *audioAssetArray = [[NSMutableArray alloc] init];
    NSMutableArray *durationArray = [[NSMutableArray alloc] init];
    [durationArray addObject:@(0)];
    
    AVMutableComposition *composition = [AVMutableComposition composition];
    
    CMTime allTime = kCMTimeZero;
    
    for (NSInteger i = 0; i < fileNameArray.count; i++) {
        NSString *auidoPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",fileNameArray[i]] ofType:@"m4a"];
        AVURLAsset *audioAsset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:auidoPath]];
        [audioAssetArray addObject:audioAsset];
        
        
        // 音频轨道
        AVMutableCompositionTrack *audioTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
        
        // 音频素材轨道
        AVAssetTrack *audioAssetTrack = [[audioAsset tracksWithMediaType:AVMediaTypeAudio] firstObject];
        
        
        // 音频合并 - 插入音轨文件
        [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration) ofTrack:audioAssetTrack atTime:allTime error:nil];
        
        // 更新当前的位置
        allTime = CMTimeAdd(allTime, audioAsset.duration);
        
    }
    
    // 合并后的文件导出 - `presetName`要和之后的`session.outputFileType`相对应。
    //    AVAudioSession *session = [AVAudioSession sharedInstance];
    //    [session setActive:YES error:nil];
    //    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    
    
    
    
    NSString *outPutFilePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"test.m4a"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:outPutFilePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:outPutFilePath error:nil];
    }
    
    // 查看当前session支持的fileType类型
    AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:composition presetName:AVAssetExportPresetAppleM4A];
    NSLog(@"outPutFilePath---%@",outPutFilePath);
    NSLog(@"---%@",[session supportedFileTypes]);
    session.outputURL = [NSURL fileURLWithPath:outPutFilePath];
    session.outputFileType = AVFileTypeAppleM4A; //与上述的`present`相对应
    session.shouldOptimizeForNetworkUse = YES;   //优化网络
    
    [session exportAsynchronouslyWithCompletionHandler:^{
        
        NSLog(@"%@",[NSThread currentThread]);
        
        if (session.status == AVAssetExportSessionStatusCompleted) {
            NSLog(@"合并成功----%@", outPutFilePath);
            
            NSURL *url = [NSURL fileURLWithPath:outPutFilePath];
//            complete?complete(url):nil;
            static SystemSoundID soundID = 0;

            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);

            AudioServicesPlayAlertSoundWithCompletion(soundID, ^{
                NSLog(@"播放完成");
                AudioServicesDisposeSystemSoundID(soundID);
            });
            
        } else {
            // 其他情况, 具体请看这里`AVAssetExportSessionStatus`.
        }
    }];
    
}

@end
