//
//  SYDebugViewController.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/26.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYDebugViewController.h"
#import "SYTitleDebugTableViewCell.h"
#import "SYSwitchDebugTableViewCell.h"
#import "SYInterfaceDebugTableViewCell.h"
#import "SYDebugModel.h"

#define k_SYSwitchDebugTableViewCell @"SYSwitchDebugTableViewCell"
#define k_SYInterfaceDebugTableViewCell @"SYInterfaceDebugTableViewCell"
#define k_SYTitleDebugTableViewCell @"SYTitleDebugTableViewCell"

@interface SYDebugViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *debugTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation SYDebugViewController
- (id)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"测试界面"];
    [self loadModel];
//    UIButton *lf = [UIButton buttonWithType:UIButtonTypeCustom];
//    lf.frame = CGRectMake(0, 0, 40, 40);
//    [lf setTitle:@"返回" forState:UIControlStateNormal];
//    [lf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [lf bk_addEventHandler:^(id sender) {
//        @strongify(self);
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:lf];
//    self.navigationItem.leftBarButtonItem = left;
//
//    UIButton *rt = [UIButton buttonWithType:UIButtonTypeCustom];
//    rt.frame = CGRectMake(0, 0, 40, 40);
//    [rt setTitle:@"保存" forState:UIControlStateNormal];
//    [rt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [rt bk_addEventHandler:^(id sender) {
//        @strongify(self);
//        [self save];
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } forControlEvents:UIControlEventTouchUpInside];
    
//    UIBarButtonItem *rtBarItem = [[UIBarButtonItem alloc] initWithCustomView:rt];
//    self.navigationItem.rightBarButtonItem = rtBarItem;
    
    [self setupSubviews];
    
}

- (void)setupSubviews
{
    
    self.debugTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.debugTableView.delegate = self;
    self.debugTableView.dataSource = self;
    [self.view addSubview:self.debugTableView];
    [self.debugTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(CY_Height_NavBar, 0, 0, 0));
    }];
    
    [self.debugTableView registerNib:[UINib nibWithNibName:k_SYSwitchDebugTableViewCell bundle:nil] forCellReuseIdentifier:k_SYSwitchDebugTableViewCell];
    [self.debugTableView registerNib:[UINib nibWithNibName:k_SYInterfaceDebugTableViewCell bundle:nil] forCellReuseIdentifier:k_SYInterfaceDebugTableViewCell];
    [self.debugTableView registerNib:[UINib nibWithNibName:k_SYTitleDebugTableViewCell bundle:nil] forCellReuseIdentifier:k_SYTitleDebugTableViewCell];
}

- (void) loadModel
{
    self.dataSource = [NSMutableArray array];
    SYInterfaceDebugModel *interfaceModel = [SYInterfaceDebugModel new];
    SYDebugFaceIDTouchIDModel *faceId = [SYDebugFaceIDTouchIDModel new];
    SYDebugClearUserInfoModel *clearModel = [SYDebugClearUserInfoModel new];
    clearModel.SYDebugType = SYDebugCell_ClearUserInfoAndLogout;
    [self.dataSource addObject:interfaceModel];
    [self.dataSource addObject:faceId];
    [self.dataSource addObject:clearModel];
    
    [self.debugTableView reloadData];
}

#pragma mark - tableViewDelegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __kindof  UITableViewCell *cell = nil;
    SYDebugModel *model = [self.dataSource objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        cell = (SYInterfaceDebugTableViewCell *)[tableView dequeueReusableCellWithIdentifier:k_SYInterfaceDebugTableViewCell];
        [cell setData:model];
    }
    else if (indexPath.row == 1){
        cell = (SYSwitchDebugTableViewCell *)[tableView dequeueReusableCellWithIdentifier:k_SYSwitchDebugTableViewCell];
        [cell setData:model];
    }
    else if (indexPath.row == 2)
    {
        cell = (SYTitleDebugTableViewCell * )[tableView dequeueReusableCellWithIdentifier:k_SYTitleDebugTableViewCell];
        [cell setData:model];
    }

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYDebugModel *model = [self.dataSource objectAtIndex:indexPath.row];
    if (indexPath.row == 2) {
        if (self.callBack) {
            self.callBack(model);
        }
    }
}

- (void) save
{
    [self.dataSource makeObjectsPerformSelector:@selector(save)];
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







