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
#import "MJChiBaoZiHeader.h"
#import "UIView+Border.h"
#import "ReactiveCocoa.h"

#import "DOPDropDownMenu1.h"

const static NSString *kTableViewCellIdentifier = @"tableViewCellIdentifier";

#define tableViewHeaderViewHeight 480.

@interface HomePageViewController ()<UITableViewDelegate, UITableViewDataSource, DOPDropDownMenuDelegate, DOPDropDownMenuDataSource>

@property (nonatomic, strong) HomePageTableHeaderView *headerView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MerchantInfoListViewModel *merchantInfoListViewModel;
@property (nonatomic, copy) NSMutableArray *merchantInfoListArray;

@property (nonatomic, strong) DOPDropDownMenu1 *dropDownMenu;

// dropDownMenu数据
@property (nonatomic, strong) NSArray *classifys;
@property (nonatomic, strong) NSArray *cates;
@property (nonatomic, strong) NSArray *movices;
@property (nonatomic, strong) NSArray *hostels;

@property (nonatomic, strong) NSArray *areas;
@property (nonatomic, strong) NSArray *sorts;
@property (nonatomic, strong) NSArray *filters;

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
    
    [self mockFiterData];

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
        _tableView.backgroundColor = [UIColor lightGrayColor];

        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

- (HomePageTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[HomePageTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, tableViewHeaderViewHeight)];

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

- (DOPDropDownMenu1 *)dropDownMenu {
    if (!_dropDownMenu) {
        _dropDownMenu = [[DOPDropDownMenu1 alloc] initWithOrigin:CGPointMake(0, tableViewHeaderViewHeight) andHeight:44.];
        [_dropDownMenu addTopBorderWithColor:[UIColor lightGrayColor] andWidth:0.5];
        _dropDownMenu.dataSource = self;
        _dropDownMenu.delegate = self;
        
         @weakify(self);
        _dropDownMenu.popWillHideBlock = ^{
             @strongify(self);
             self.tableView.scrollEnabled = YES;
        };
        _dropDownMenu.popWillShowBlock = ^{
             @strongify(self);
             self.tableView.scrollEnabled = NO;
        };
    }
   
    return  _dropDownMenu;
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 105.;
    
    return height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.dropDownMenu;
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

#pragma mark - helper methods

- (void)loadMoreData {
    // 2.模拟1秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [tableView.mj_footer endRefreshing];
    });
}

- (void)loadNewData {
    // 2.模拟1秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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

- (void)mockFiterData {
    self.classifys = @[@"美食",@"今日新单",@"电影",@"酒店"];
    self.cates = @[@"自助餐",@"快餐",@"火锅",@"日韩料理",@"西餐",@"烧烤小吃"];
    self.movices = @[@"内地剧",@"港台剧",@"英美剧"];
    self.hostels = @[@"经济酒店",@"商务酒店",@"连锁酒店",@"度假酒店",@"公寓酒店",@"全城",@"芙蓉区",@"雨花区",@"天心区",@"开福区",@"岳麓区"];
    self.areas = @[@"全城",@"芙蓉区",@"雨花区",@"天心区",@"开福区",@"岳麓区"];
    self.sorts = @[@"默认排序",@"离我最近",@"好评优先",@"人气优先",@"最新发布"];
    self.filters = @[@"全城",@"芙蓉区",@"雨花区",@"天心区",@"开福区",@"岳麓区"];
}

#pragma mark - DOPDropDownMenuDataSource

/**
 *  返回 menu 第column列有多少行
 */
- (NSInteger)menu:(DOPDropDownMenu1 *)menu numberOfRowsInColumn:(NSInteger)column {
    NSUInteger rows = 1;
    switch (column) {
        case 0:
            rows = [self.classifys count];
            break;
        case 1:
            rows = [self.areas count];
            break;
        case 2:
            rows = [self.sorts count];
            break;
        case 3:
            rows = [self.sorts count];
            break;
        default:
            break;
    }
    
    return rows;
}

/**
 *  返回 menu 第column列 每行title
 */
- (NSString *)menu:(DOPDropDownMenu1 *)menu titleForRowAtIndexPath:(DOPIndexPath1 *)indexPath {
    NSString *title = @"";
    switch (indexPath.column) {
        case 0:
            title = self.classifys[indexPath.row];
            break;
        case 1:
            title = self.areas[indexPath.row];
            break;
        case 2:
            title = self.sorts[indexPath.row];
            break;
        case 3:
            title = self.sorts[indexPath.row];
            break;
        default:
            break;
    }
    
    return title;
}

/**
 *  返回 menu 有多少列 ，默认1列
 */
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu1 *)menu {
    return 4;
}

// 新增 返回 menu 第column列 每行image
- (NSString *)menu:(DOPDropDownMenu1 *)menu imageNameForRowAtIndexPath:(DOPIndexPath1 *)indexPath {
    if (indexPath.column == 0 || indexPath.column == 1) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld",indexPath.row];
    }
    
    return nil;
}

- (NSInteger)menu:(DOPDropDownMenu1 *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        if (row == 0) {
            return self.cates.count;
        } else if (row == 2){
            return self.movices.count;
        } else if (row == 3){
            return self.hostels.count;
        }
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu1 *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath1 *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            return self.cates[indexPath.item];
        } else if (indexPath.row == 2){
            return self.movices[indexPath.item];
        } else if (indexPath.row == 3){
            return self.hostels[indexPath.item];
        }
    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu1 *)menu detailTextForRowAtIndexPath:(DOPIndexPath1 *)indexPath
{
    if (indexPath.column < 2) {
        return [@(arc4random()%1000) stringValue];
    }
    
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu1 *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath1 *)indexPath
{
    return [@(arc4random()%1000) stringValue];
}

#pragma mark - DOPDropDownMenuExtendDelegate

- (void)menu:(DOPDropDownMenu1 *)menu didSelectColumn:(NSUInteger)column {
    // 在这里尝试做动画
    [UIView animateWithDuration:2. animations:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }];
    NSLog(@"I select column--%ld ", column);
}

#pragma mark - DOPDropDownMenuDelegate

/**
 *  点击代理，点击了第column 第row 或者item项，如果 item >=0
 */
- (void)menu:(DOPDropDownMenu1 *)menu didSelectRowAtIndexPath:(DOPIndexPath1 *)indexPath {
    // 在这里尝试做动画
    [UIView animateWithDuration:2. animations:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }];
    
    NSLog(@"I select %ld--%ld--%ld ", indexPath.column, indexPath.row, indexPath.item);
}

@end
