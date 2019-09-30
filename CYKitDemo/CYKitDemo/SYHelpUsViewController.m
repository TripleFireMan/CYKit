
//
//  SYHelpUsViewController.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/7.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYHelpUsViewController.h"
#import "UIView+CYAddition.h"
#import "SYHelpUsContentCollectionViewCell.h"
#import "SYHelpUsRightCollectionViewCell.h"
#import "HttpTool.h"
#import "SYHelpUsHeaderView.h"
#import "SYHelpUsModel.h"
#import "SYArticleDetailViewController.h"
#import "SYCollectionViewFlowLayout.h"

@interface SYHelpUsViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet SYHelpUsHeaderView *helpHeaderView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *rightCollectView;
@property (nonatomic, assign) NSInteger curIndex;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation SYHelpUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"使用帮助"];
    [self setShouldShowHeaderImage:NO];
    self.curIndex = 0;
    
    self.headerView.backgroundColor = [UIColor clearColor];
    self.dataSource = [NSMutableArray array];
    
    SYHelpUsHeaderView *headerView = [SYHelpUsHeaderView cy_loadCurrentViewFromNib];
    headerView.clipsToBounds = YES;
    [self.helpHeaderView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
//    headerView.frame = self.helpHeaderView.frame;
    
    
    
    // 注册cell
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SYHelpUsContentCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"SYHelpUsContentCollectionViewCell"];
    [self.rightCollectView registerNib:[UINib nibWithNibName:@"SYHelpUsRightCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SYHelpUsRightCollectionViewCell"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    
    layout.estimatedItemSize = CGSizeMake(75, 100);

    self.collectionView.collectionViewLayout = layout;

    UICollectionViewFlowLayout *rightLayout = [[UICollectionViewFlowLayout alloc] init];
    rightLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    rightLayout.minimumLineSpacing = 0;
    rightLayout.estimatedItemSize = CGSizeMake(kScreenWidth - 75 - 2, 50);
    self.rightCollectView.collectionViewLayout = rightLayout;
    
    [self.view bringSubviewToFront:self.headerView];
    
    self.collectionView.alwaysBounceVertical = YES;
    self.rightCollectView.alwaysBounceVertical = YES;
    
    [self p_loadData];
}

- (void) p_loadData
{
    [HttpTool GETWithAction:@"ArticlesByHelp" content:nil HUD:YES successWithStatus:^(id data, NSInteger statusCode, NSString *msg) {
        if (statusCode == 10002) {
            if ([data isKindOfClass:[NSArray class]]) {
                NSArray *dataArr = [NSArray modelArrayWithClass:[SYHelpUsModel class] json:data];
                SYHelpUsModel *model = [dataArr firstObject];
                if (model) {
                    model.isSeleted = YES;
                }
                [self.dataSource addObjectsFromArray:dataArr];
                [self.collectionView reloadData];
                [self.rightCollectView reloadData];
            }
        }
    } failure:nil];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.collectionView) {
        return self.dataSource.count;
    }
    else if (collectionView == self.rightCollectView){
        if (self.dataSource.count > self.curIndex) {
            SYHelpUsModel *model = [self.dataSource objectAtIndex:self.curIndex];
            return model.children.count;
        }
    }
    return 0;
}

- (__kindof UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionView) {
        SYHelpUsContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYHelpUsContentCollectionViewCell" forIndexPath:indexPath];
        SYHelpUsModel *model = [self.dataSource objectAtIndex:indexPath.row];
        [cell config:model];
        return cell;
    }
    else{
        SYHelpUsRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYHelpUsRightCollectionViewCell" forIndexPath:indexPath];
        SYHelpUsModel *model = [self.dataSource objectAtIndex:self.curIndex];
        SYHelpUsSubModel *subModel = [[model children] objectAtIndex:indexPath.row];
        [cell configModel:subModel];
        return cell;
    }

}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionView) {
        [self.dataSource enumerateObjectsUsingBlock:^(SYHelpUsModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSeleted = NO;
        }];
        SYHelpUsModel *model = [self.dataSource objectAtIndex:indexPath.row];
        model.isSeleted = YES;
        self.curIndex = indexPath.row;
        
        [self.collectionView reloadData];
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.rightCollectView reloadData];
        [self.rightCollectView.collectionViewLayout invalidateLayout];
    }
    else{
        SYHelpUsModel *model = [self.dataSource objectAtIndex:self.curIndex];
        SYHelpUsSubModel *subModel = [model.children objectAtIndex:indexPath.row];
        SYArticleDetailViewController *detail = [SYArticleDetailViewController new];
        detail.subModel = subModel;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

- (void) p_reloadRightCollectionView
{
    
}





@end
