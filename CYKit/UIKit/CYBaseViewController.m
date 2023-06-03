//
//  CYBaseViewController.m
//  AFNetworking
//
//  Created by 成焱 on 2019/8/30.
//

#import "CYBaseViewController.h"
#import <Masonry/Masonry.h>
#import "CYKitDefines.h"


@interface CYBaseViewController ()
@property (nonatomic, strong) UIImageView *heaerImageView;
@end

@implementation CYBaseViewController

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.headerView = [UIView new];
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.offset(CY_Height_NavBar);
    }];
    
    self.heaerImageView =[UIImageView new];
    self.heaerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.heaerImageView.clipsToBounds = YES;
    [self.headerView addSubview:self.heaerImageView];
    [self.heaerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    self.heaerImageView.hidden = YES;
    
    
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"CYKit" ofType:@"bundle"]];
    UIImage *bgImage = [[UIImage imageNamed:@"back" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.backBtn setImage:bgImage forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    self.backBtn.tintColor = [UIColor blackColor];
    
    [self.headerView addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.offset(-5);
        make.height.width.offset(40);
    }];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.textColor = [UIColor darkTextColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backBtn);
        //        make.centerX.mas_equalTo(self.headerView);
        make.left.mas_equalTo(self.backBtn.mas_right).offset(10);
        make.right.offset(-60);
    }];
    [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    self.bottomLine = [UIView new];
    self.bottomLine.backgroundColor = RGBColor(200, 200, 200);
    [self.headerView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(CY_Sigle_Line_Height);
    }];
    
    self.bottomLine.hidden = YES;
    
    [self p_adjustForIOS13];
    
    [self setupSubView];
    
    [self addConstraints];
}

- (void) setupSubView
{
    
}

- (void) addConstraints
{
    
}


- (void)backbtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setShouldShowBackBtn:(BOOL)shouldShowBackBtn
{
    _shouldShowBackBtn = shouldShowBackBtn;
    self.backBtn.hidden = !_shouldShowBackBtn;
}

- (void) setShouldShowHeader:(BOOL)shouldShowHeader
{
    _shouldShowHeader = shouldShowHeader;
    self.headerView.hidden = !_shouldShowHeader;
}

- (void) setShouldShowBottomLine:(BOOL)shouldShowBottomLine{
    _shouldShowBottomLine = shouldShowBottomLine;
    self.bottomLine.hidden = !_shouldShowBottomLine;
}

- (void) setTitle:(NSString *)title
{
    [super setTitle:title];
    self.titleLabel.text = title;
    
}

- (void) setShouldShowHeaderImage:(BOOL)shouldShowHeaderImage
{
    _shouldShowHeaderImage = shouldShowHeaderImage;
    self.heaerImageView.hidden = !_shouldShowHeaderImage;
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//
//    return UIStatusBarStyleLightContent;
//
//}

- (void) p_adjustForIOS13
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
    if (@available(iOS 13, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        self.view.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        
    }
#endif
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
+ (CGFloat) cyStatusBarHeight{
    return  CY_Height_StatusBar;
}
+ (CGFloat) cyNavibarHeight{
    return CY_Height_NavBar;
}
+ (CGFloat) cyBottomBarHeight{
    return CY_Height_Bottom_SafeArea;
}
+ (CGFloat) cyTabbarHeight{
    return CY_Height_TabBar;
}
@end
