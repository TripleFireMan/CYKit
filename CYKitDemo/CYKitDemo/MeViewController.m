//
//  MeViewController.m
//  CYKitDemo
//
//  Created by chengyan on 17/3/20.
//  Copyright © 2017年 cheng.yan. All rights reserved.
//

#import "MeViewController.h"
#import "CYMeModel.h"
#import "CYH5ViewController.h"

@interface MeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.dataSource = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CY_Height_NavBar);
        make.left.right.offset(0);
        make.bottom.offset(0);
    }];
    
    [self loadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)loadData
{
    
    NSArray *titles = @[@"H5容器"];
    
    for (int i = 0; i < titles.count; i++) {
        CYMeModel *model = [CYMeModel new];
        model.title = titles[i];
        [self.dataSource addObject:model];
    }
    
    [self.tableView reloadData];
    
}

#pragma mark - tableViewDelegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DefaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CYMeModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.textLabel.text = model.title;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYMeModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    if ([model.title isEqualToString:@"H5容器"]) {
        CYH5ViewController *h5 = [[CYH5ViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        [self.navigationController pushViewController:h5 animated:YES];
    }
}


@end










