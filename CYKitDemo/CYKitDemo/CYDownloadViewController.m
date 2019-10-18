//
//  CYDownloadViewController.m
//  CYKitDemo
//
//  Created by 成焱 on 2019/10/15.
//  Copyright © 2019 cheng.yan. All rights reserved.
//

#import "CYDownloadViewController.h"
#import "CYDownloadModel.h"
#import "CYDownloadSessionManager.h"
#import "ReactiveObjC.h"
#import <MediaPlayer/MediaPlayer.h>

#import <AVKit/AVKit.h>
static NSString * const downloadUrl = @"http://139.219.15.132:8766/video/test.mp4";
static NSString * const downloadUrl1 = @"http://v3-default.ixigua.com/1b84bb86e397763e7736c58916a9258e/5da6e8b5/video/m/2205c26c31388ba4c5eb47e71389cc753991163b74d20000937a218f89c0/?a=1217&br=385&cr=0&cs=0&dr=0&ds=2&er=&l=2019101616502801001404707504086A16&lr=&rc=M2Y5NDM0aWxscDMzNzczM0ApZzs0Zmg0ZTs5N2k0aTk1Z2cuYWhjazMwZWFfLS0zLTBzc2BgY19gYS5hNDUyMS8wYmE6Yw%3D%3D";
static NSString * const downloadUrl2 = @"http://v3-default.ixigua.com/d28d263b7380d1af2e6f73f739a44141/5da6fa03/video/m/220681988039e324d01be2f97244b31903011633c56500009d222c540806/?a=1217&br=629&cr=0&cs=0&dr=0&ds=2&er=&l=201910161802420100140481351515BB69&lr=&rc=anlwaGY2NHFrbzMzZzczM0ApNWYzZDk3ODszN2c2NWQ5NGdnbi9sYmtwamBfLS1fLS9zczFeMV9gYmAwMzY1YjQxMjM6Yw%3D%3D";


@interface CYDownloadViewController ()
@property (nonatomic, strong) UILabel *lbl1;
@property (nonatomic, strong) UIProgressView *progress1;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UILabel *lbl2;
@property (nonatomic, strong) UIProgressView *progress2;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) CYDownloadModel *downloadmodel;
//播放器视图控制器
@property (nonatomic,strong) AVPlayerViewController *moviePlayerViewController;
@end

@implementation CYDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"下载demo";
    @weakify(self);
    self.view.backgroundColor = [UIColor whiteColor];
    self.lbl1 = [UILabel new];
    self.lbl1.numberOfLines = 0;
    [self.view addSubview:self.lbl1];
    
    self.progress1 = [UIProgressView new];
    [self.view addSubview:self.progress1];

    self.btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btn1 setTitle:@"开始下载" forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.downloadmodel = [[CYDownloadModel alloc] initWithURL:downloadUrl];
    [self.btn1 bk_addEventHandler:^(id sender) {
        @strongify(self);
        //查询当前是否有相应的url对应的任务在下载
        
        //1. 创建下载模型
        if (self.downloadmodel.state == CYDownload_Wait ||
            self.downloadmodel.state == CYDownload_Init) {
            [[CYDownloadSessionManager shareInstance] startDownload:self.downloadmodel progress:^(CYDownloadProgress * _Nonnull progress) {
                self.progress1.progress = progress.progress;
            } state:^(CYDownloadStatus status, NSString * _Nonnull filePath, NSError * _Nonnull error) {
                if (error) {
                    [XHToast showBottomWithText:@"下载失败"];
                }
                else{
                    if (status == CYDownload_Downloaded) {
                        [XHToast showBottomWithText:@"下载完成"];
                        self.moviePlayerViewController = [[AVPlayerViewController alloc] init];
                        self.moviePlayerViewController.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:self.downloadmodel.destinationFilePath]];
                        [self presentViewController:self.moviePlayerViewController animated:YES completion:nil];
                    }
                }
            }];
        }
        
        
        else if (self.downloadmodel.state == CYDownload_Downloading){
            [[CYDownloadSessionManager shareInstance] pause:self.downloadmodel];
        }
        else if (self.downloadmodel.state == CYDownload_Pause){
            [[CYDownloadSessionManager shareInstance] resume:self.downloadmodel];
        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [RACObserve(self.downloadmodel, state) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.btn1 setTitle:[self.downloadmodel stateDescription] forState:UIControlStateNormal];
    }];
    
    [self.view addSubview:self.btn1];
    

    self.lbl2 = [UILabel new];
    self.lbl2.numberOfLines = 0;
    [self.view addSubview:self.lbl2];
    
    self.progress2 = [UIProgressView new];
    [self.view addSubview:self.progress2];

    self.btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btn2 setTitle:@"开始下载" forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn2 bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn2];

    [self.lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.offset(CY_Height_NavBar + 20);
    }];
    
    [self.progress1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.lbl1);
        make.top.mas_equalTo(self.lbl1.mas_bottom).offset(20);
    }];
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.progress1.mas_bottom).offset(40);
        make.centerX.offset(0);
    }];
    
//    [self.lbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.btn1.mas_bottom).offset(50);
//        make.left.offset(30);
//        make.right.offset(-30);
//    }];
//
//    [self.progress2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.lbl2);
//        make.top.mas_equalTo(self.lbl2.mas_bottom).offset(20);
//    }];
//
//    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.progress2.mas_bottom).offset(40);
//        make.centerX.offset(0);
//    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
