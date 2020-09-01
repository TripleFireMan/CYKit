//
//  SYAboutUsViewController.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/7.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYAboutUsViewController.h"
#import "SYAboutUsTableViewCell.h"
#import "SYAboutUsModel.h"
#import "SYAboutUsHeaderView.h"
#import "SYDebugViewController.h"
#import "CYWeixinLoginViewController.h"
#define MAX_COUNT 10
@interface SYAboutUsViewController ()<
UITableViewDelegate,
UITableViewDataSource>
@property (nonatomic, assign) NSInteger clickCount;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation SYAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"版本介绍"];
    self.dataSource = [NSMutableArray array];
    @weakify(self);
//    SYAboutUsModel *modle1 = [SYAboutUsModel new];
//    modle1.name = @"版本更新";
//    SYAboutUsModel *modle2 = [SYAboutUsModel new];
//    modle2.name = @"版本说明";
//    [self.dataSource addObject:modle1];
//    [self.dataSource addObject:modle2];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(CY_Height_NavBar);
        make.bottom.offset(0);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SYAboutUsTableViewCell" bundle:nil] forCellReuseIdentifier:@"SYAboutUsTableViewCell"];
    // Do any additional setup after loading the view from its nib.
    
    SYAboutUsHeaderView *headerView = [SYAboutUsHeaderView new];
    self.tableView.tableHeaderView = headerView;
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.width.offset(kScreenWidth);
        make.height.offset(245);
    }];
    
//    [headerView bk_whenTapped:^{
//        @strongify(self);
//        self.clickCount ++;
//        if (self.clickCount >= MAX_COUNT) {
//            self.clickCount = 0;
//
//            SYDebugViewController *debugVc = [SYDebugViewController new];
//            @weakify(debugVc);
//            debugVc.callBack = ^(SYDebugModel * _Nonnull model) {
//                if (model.SYDebugType == SYDebugCell_ClearUserInfoAndLogout) {
//                    @strongify(debugVc);
//                    [debugVc dismissViewControllerAnimated:YES completion:^{
//                        UINavigationController *nav = self.navigationController;
//                        [self.navigationController popToRootViewControllerAnimated:YES];
//                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                            [[SYUser currentUser] logout];
//                            CYWeixinLoginViewController* vc = [[CYWeixinLoginViewController alloc]init];
//                            vc.mytag = @"1";
//                            vc.hidesBottomBarWhenPushed = YES;
//                            [nav pushViewController:vc animated:YES];
//                            //发送退出登录的通知
////                            [[NSNotificationCenter defaultCenter] postNotificationName:k_DidLoginOrLogoutNotification object:nil userInfo:@{k_DidLoginOrLogoutKey:@(NO)}];
//                        });
//                    }];
//
//                }
//            };
//            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:debugVc];
//            navi.modalPresentationStyle = UIModalPresentationFullScreen;
//            [self presentViewController:navi animated:YES completion:nil];
//
//            [XHToast showBottomWithText:[NSString stringWithFormat:@"环境切换成功,当前环境:%@",(SYDebugMacro() == YES ?@"测试":@"正式")]];
//        }
//    }];
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - tableViewDelegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SYAboutUsTableViewCell";
    SYAboutUsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    SYAboutUsModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell config:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.f;
}



@end
