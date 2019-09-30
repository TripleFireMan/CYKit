//
//  SYLaunchViewController.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/14.
//  Copyright © 2019 sy. All rights reserved.
//

#import "CYLaunchViewController.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "BlocksKit+UIKit.h"
#import "CYKitDefines.h"
#import "ReactiveObjC.h"
#define k_UserDefault_LaunchImageKey    @"k_UserDefault_LaunchImageKey"
#define k_UserDefault_LaunchImageInvalidTimeKey @"k_UserDefault_LaunchImageInvalidTimeKey"

// 设置倒计时需要的时间
static NSInteger CY_CountDownTime = 3;
// 设置图片过期时间
static NSTimeInterval CY_PICTURE_INVALIED_TIME = 3 * 24 * 60 * 60;

@interface CYLaunchViewController ()
/// 3s倒计时关闭按钮
@property (nonatomic, strong) UIButton *closeBtn;
/// 启动图
@property (nonatomic, strong) UIImageView *launchImageView;
/// 定时器
@property (nonatomic, strong) NSTimer *timer;
/// 广告图的地址，
@property (nonatomic, strong) NSString *imgUrl;
/// 下载类
@property (nonatomic, strong) AFURLSessionManager *sessionManager;

@property (nonatomic, assign) BOOL hasJumpToHome;


@end

@implementation CYLaunchViewController

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.countDown = CY_CountDownTime;
        self.invaliedTime = CY_PICTURE_INVALIED_TIME;
        self.countDownTextColor = [UIColor colorWithRed:250.f/255.f green:77.f/255.f blue:57.f/255 alpha:1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
    if (self.CYFetchImageUrlBlock) {
        self.CYFetchImageUrlBlock();
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)setUpSubViews
{
    @weakify(self);
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setTitleColor:self.countDownTextColor forState:UIControlStateNormal];
    [self.closeBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        [self jumpToHomePage];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.closeBtn setTitle:[NSString stringWithFormat:@"%@s",@(self.countDown)] forState:UIControlStateNormal];
    self.closeBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.closeBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    self.closeBtn.hidden = YES;
    [self.view addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.top.offset(CY_Height_StatusBar + 20);
        make.width.offset(60);
        make.height.offset(30);
    }];
    self.closeBtn.layer.cornerRadius = 15.f;
    self.closeBtn.layer.masksToBounds = YES;
    
    self.launchImageView = [UIImageView new];
    self.launchImageView.image = [self p_getImage];
    [self.view addSubview:self.launchImageView];
    [self.launchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    [self.view bringSubviewToFront:self.closeBtn];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.countDown * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!self.hasJumpToHome && !self.timer) {
            [self jumpToHomePage];
        }
    });
    
}

- (void)createTimer
{
    [self.timer invalidate];
    self.timer = nil;
    @weakify(self);
    self.timer = [NSTimer bk_timerWithTimeInterval:1 block:^(NSTimer *timer) {
        @strongify(self);
        self.countDown --;
        self.closeBtn.hidden = NO;
        [self.closeBtn setTitle:[NSString stringWithFormat:@"%@s",@(self.countDown)] forState:UIControlStateNormal];
        
        if (self.countDown <= 0) {
            [self jumpToHomePage];
        }
        
    } repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//- (void)loadData
//{
//    [HttpTool GETWithAction:ACTION_LAUNCH_IMAGE content:nil HUD:NO successWithStatus:^(id data, NSInteger statusCode, NSString *msg) {
//        if (statusCode == k_SuoYiInterfaceSuccessCode) {
//            if ([data isKindOfClass:[NSString class]]) {
//                self.imgUrl = data;
//                [self downLoadImage];
//            }
//        }
//    } failure:^(NSError *error) {
//        [self jumpToHomePage];
//    }];
//}

- (void)downLoadImage:(NSString *)url
{
    self.imgUrl = url;
    self.sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:nil];
    NSURL *imageUrl = [NSURL URLWithString:self.imgUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
    NSString *imgUrMd5String = @"kUserLaucnImage";
    @weakify(self);
    [[self.sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *cacheFilePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
        NSString *destionNation = [cacheFilePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imgUrMd5String]];
        return [NSURL fileURLWithPath:destionNation];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        @strongify(self);
        NSLog(@"filepath:%@",filePath);
        if (!error && filePath) {
            NSString *documentUrl = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
            NSString *destionNation = [documentUrl stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imgUrMd5String]];
            NSURL *url = [NSURL fileURLWithPath:destionNation];
            NSError *error = nil;
            if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
                [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
            }
            [[NSFileManager defaultManager] moveItemAtURL:filePath toURL:url error:&error];
            NSLog(@"error === %@",error);
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (img) {
                    self.launchImageView.image = img;
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"kUserLaucnImage.png"] forKey:k_UserDefault_LaunchImageKey];
                    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:self.invaliedTime];
                    [[NSUserDefaults standardUserDefaults] setObject:date forKey:k_UserDefault_LaunchImageInvalidTimeKey];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    if (!self.timer) {
                        self.closeBtn.hidden = NO;
                        [self createTimer];
                    }
                }
                else{
                    [self jumpToHomePage];
                }
            });
        }
        else{
            [self jumpToHomePage];
        }

    }]resume];
}


- (UIImage *)p_getImage
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *imgString = [[NSUserDefaults standardUserDefaults] objectForKey:k_UserDefault_LaunchImageKey];
    imgString = [documentPath stringByAppendingPathComponent:imgString];
    NSDate *invalidDate = [[NSUserDefaults standardUserDefaults] objectForKey:k_UserDefault_LaunchImageInvalidTimeKey];
    if (invalidDate) {
        NSDate *today = [NSDate date];
        //图片过期了
        if ([today timeIntervalSinceDate:invalidDate] >= 0) {
            return [[self class] getLaunchImage];
        }
        else{
            //未过期，有图片
            if (imgString && [[NSFileManager defaultManager] fileExistsAtPath:imgString]) {
                NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:imgString]];
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    self.closeBtn.hidden = NO;
                    [self createTimer];
                    return image;
                }
                else{
                    return [[self class] getLaunchImage];
                }
                
            }
            else{
                return [[self class] getLaunchImage];
            }
        }
    }
    else{
        return [[self class] getLaunchImage];
    }
}

+ (UIImage *)getLaunchImage{
    
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOr = @"Portrait";//垂直
    NSString *launchImage = nil;
    NSArray *launchImages =  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    for (NSDictionary *dict in launchImages) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(viewSize, imageSize) && [viewOr isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    UIImage *img = [UIImage imageNamed:@"WechatIMG98-2"];
    return img;
}

- (void) jumpToHomePage
{
    self.hasJumpToHome = YES;
    [self.timer invalidate];
    self.timer = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:k_DidFinishLaunchNotification object:self];
}

- (void) finishLaunch
{
    [self jumpToHomePage];
}




@end










