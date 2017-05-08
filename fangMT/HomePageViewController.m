//
//  HomePageViewController.m
//  fangMT
//
//  Created by Rong on 2017/5/3.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "HomePageViewController.h"
#import "MerchantInfoListTableViewCell.h"
#import "HomePageTableHeaderView.h"
#import "MerchantInfoListModel.h"
#import "MerchantInfoListViewModel.h"
#import "FilterConditionLineView.h"
#import "MJChiBaoZiHeader.h"
#import "UIView+Border.h"

const static NSString *kTableViewCellIdentifier = @"tableViewCellIdentifier";

@interface HomePageViewController ()<UITableViewDelegate, UITableViewDataSource, FilterConditionLineViewDelegate>

@property (nonatomic, strong) HomePageTableHeaderView *headerView;
@property (nonatomic, strong) FilterConditionLineView *filterConditionLineView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MerchantInfoListViewModel *merchantInfoListViewModel;
@property (nonatomic, copy) NSMutableArray *merchantInfoListArray;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISearchBar *searchView = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100., 40.)];
    searchView.placeholder = @"输入商家名、品类或商圈";
    self.navigationItem.titleView = searchView;

    [self configTableViewHeaderAndFooter];
    
    [_tableView registerClass:[MerchantInfoListTableViewCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = self.headerView;
    
    // do request   
    [self.merchantInfoListViewModel fetchMerchantInfoListWithURL:[NSURL URLWithString:@"XXX"]
                                                           Doing:^(id obj) {
                                                               // 在请求中需要做一些事写在这里
                                                           }
                                                         Success:^(id obj) {
                                                             // 请求成功后,在这将解析的数据存放在_merchantInfoListArray数组中
                                                             _merchantInfoListArray = nil;
                                                         }
                                                         Failure:^(id obj) {
                                                             // 请求失败后可以在这里做一些事
                                                         }];
    
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_footer beginRefreshing];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - setter & getter

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

- (HomePageTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[HomePageTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 220.)];
        [_headerView configHomePageTableHeaderView];
        [_headerView addTopBorderWithColor:[UIColor lightGrayColor] andWidth:0.5];
    }
    
    return _headerView;
}

- (MerchantInfoListViewModel *)merchantInfoListViewModel {
    if (!_merchantInfoListViewModel) {
        _merchantInfoListViewModel = [[MerchantInfoListViewModel alloc] init];
    }
    
    return _merchantInfoListViewModel;
}

- (NSMutableArray *)merchantInfoListArray {
    if (!_merchantInfoListArray) {
        _merchantInfoListArray = [[NSMutableArray alloc ] init];
    }
    
    return _merchantInfoListArray;
}

- (FilterConditionLineView *)filterConditionLineView {
    if (!_filterConditionLineView) {
        _filterConditionLineView = [[FilterConditionLineView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 39.)];
        NSArray *conditionsCatergory = @[@"全部",
                                         @"附近",
                                         @"智能排序",
                                         @"筛选"
                                        ];
        NSArray *conditionsDetailCatergory = @[@[@"甜点饮品",@"生日蛋糕",@"火锅",@"自助餐",@"小吃快餐",@"日韩料理",@"西餐",@"聚餐宴请"],
                                               @[@"1千米",@"3千米",@"5千米",@"10千米",@"全城"],
                                               @[@"离我最近",@"好评优先",@"人气最高"],
                                               @[@"1千米",@"3千米",@"5千米",@"10千米",@"全城"]];
        
        _filterConditionLineView.fourCategoryArray = [conditionsCatergory mutableCopy];
        _filterConditionLineView.fourCategoryDetailArray = [conditionsDetailCatergory mutableCopy];
        _filterConditionLineView.delegate = self;
        [_filterConditionLineView configLineView];
    }
    
    return _filterConditionLineView;
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 105.;
    
    return height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 39.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.filterConditionLineView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // todo
    
    NSLog(@"tableView--%ld--%ld",(long)indexPath.section, (long)indexPath.row);
}

#pragma mark - UITableviewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    //return [_merchantInfoListArray count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MerchantInfoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier forIndexPath:indexPath];
    //MerchantInfoListModel *merchantInfoListModel = [_merchantInfoListArray objectAtIndex:indexPath.row];
    //[cell ConfigCellWithMerchantInfoListModel:merchantInfoListModel];
    
    return cell;
}

#pragma mark -- helper methods

- (void)loadMoreData {
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [tableView.mj_footer endRefreshing];
    });
}

- (void)loadNewData {
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}

- (void)configTableViewHeaderAndFooter {
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [footer setTitle:@"下拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据了～" forState:MJRefreshStateNoMoreData];
    
    self.tableView.mj_footer = footer;
}

#pragma mark - FilterConditionLineViewDelegate

- (void)clickFilterButtonWithBlock:(void (^)(void))block {
    [UIView animateWithDuration:2. animations:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:    UITableViewScrollPositionTop animated:YES];
    }];
    
    block();
}

@end
