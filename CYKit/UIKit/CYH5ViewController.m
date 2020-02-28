//
//  CYH5ViewController.m
//  CYKit
//
//  Created by 成焱 on 2019/8/30.
//

#import "CYH5ViewController.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"
#import "CYKitDefines.h"
#import "BlocksKit.h"
#import "BlocksKit+UIKit.h"
#import "ReactiveObjC.h"


API_AVAILABLE(ios(8.0))
@interface CYH5ViewController ()<WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) NSMutableDictionary *jsEvents;

@end

@implementation CYH5ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    @weakify(self);
    
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    [close setImage:[[UIImage imageNamed:@"image_navigation_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    close.tintColor = [UIColor whiteColor];
    [close bk_addEventHandler:^(id sender) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    self.closeBtn = close;
    [self.headerView addSubview:close];
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.bottom.offset(-5);
        make.width.height.offset(40);
    }];
    
    if (@available(iOS 8.0, *)) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        config.preferences = [[WKPreferences alloc] init];
        
        config.preferences.minimumFontSize = 10;
        
        config.preferences.javaScriptEnabled = YES;
        
        config.userContentController = [[WKUserContentController alloc] init];
        
        config.processPool = [[WKProcessPool alloc] init];
        
        self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        [self.webView setNavigationDelegate:self];
        if (@available(iOS 11.0, *)) {
            self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {

        }
        
        [self.view addSubview:self.webView];
    } else {
        // Fallback on earlier versions
    }
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if(self.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    }
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, CY_Height_NavBar, [[UIScreen mainScreen] bounds].size.width, 1)];
    self.progressView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.progressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(CY_Height_NavBar, 0, 0, 0));
    }];
    
    [RACObserve(self.webView, canGoBack) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if([x boolValue]){
            self.closeBtn.hidden = NO;
        }
        else{
            self.closeBtn.hidden = YES;
        }
    }];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"RegisteSuccess"];
}

- (instancetype) initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}
- (void)backbtn{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    self.tabBarController.tabBar.hidden = NO;
}

- (void) setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    if (_urlString) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object change:(NSDictionary *)change
                      context:(void *)context
{
    if ([object isEqual:self.webView] && [keyPath isEqualToString:@"estimatedProgress"]) { // 进度条
        
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        NSLog(@"打印测试进度值：%f", newprogress);
        
        if (newprogress == 1) { // 加载完成
            // 首先加载到头
            [self.progressView setProgress:newprogress animated:YES];
            // 之后0.3秒延迟隐藏
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                weakSelf.progressView.hidden = YES;
                [weakSelf.progressView setProgress:0 animated:NO];
            });
            
        } else { // 加载中
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    } else if ([object isEqual:self.webView] && [keyPath isEqualToString:@"title"]) { // 标题
        if (![self.webView.title isEqualToString:@"123"]) {
            if (self.navigationController.viewControllers.count!=1) {
                self .title = self.webView.title;
            }
        }
    } else { // 其他
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
 API_AVAILABLE(ios(8.0)){
    NSLog(@"方法名 %@，传回参数 %@",message.name,message.body);
    
     
     JSBlock obj = [self.jsEvents objectForKey:message.name];
     if(obj){
         obj(message.name);
     }
}

- (void) registeWithName:(NSString *)jsName completeBlock:(nonnull JSBlock)block
{
    [self.jsEvents setObject:block forKey:jsName];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:jsName];
}

- (NSMutableDictionary *) jsEvents
{
    if (!_jsEvents) {
        _jsEvents = [NSMutableDictionary dictionary];
    }
    return _jsEvents;
}
@end
