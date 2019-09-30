//
//  SYArticleDetailViewController.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/8.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYArticleDetailViewController.h"
#import <WebKit/WebKit.h>
#import "SYArticleModel.h"

@interface SYArticleDetailViewController ()
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) SYArticleModel *article;
@property (nonatomic, strong) UIWebView *web;
@end

@implementation SYArticleDetailViewController
- (instancetype) init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"文章详情"];
    [self p_loadData];
}

- (void) setupSubviews
{
    self.web = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.web.scrollView.showsVerticalScrollIndicator = NO;
    self.web.scrollView.maximumZoomScale = 1.f;
    self.web.backgroundColor = [UIColor clearColor];
    self.web.opaque = NO;
    [self.view addSubview:self.web];
    [self.web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.right.offset(-8);
        make.bottom.offset(0);
        make.top.offset(CY_Height_NavBar + 0);
    }];
}

- (void) p_loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.subModel.ID forKey:@"article"];
    [HttpTool GETWithAction:@"ArticleInfo"
                    content:params
                        HUD:YES
          successWithStatus:^(id data, NSInteger statusCode, NSString *msg) {
              if (statusCode == 10002) {
                  self.article = [SYArticleModel modelWithJSON:data];
                  [self p_configSubviews];
              }
              else{
                  [self p_showErrorView];
              }
          } failure:^(NSError *error) {
              [self p_showErrorView];
          }];
}

- (void) p_configSubviews
{
    [self setTitle:self.article.Title];
    [self.web loadHTMLString:self.article.Content baseURL:nil];
}

- (void) p_showErrorView
{
//    @weakify(self);
//    [self.view showEmptyImage:@"sy_no_message" clickRefresh:^{
//        @strongify(self);
//        [self.view hideImages];
//        [self p_loadData];
//    }];
}


@end
