//
//  FMTHomePageViewController.m
//  fangMT
//
//  Created by Rong on 2017/5/3.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FMTHomePageViewController.h"
#import "FMTMerchantInfoListTableViewCell.h"
#import "FMTHomePageTableHeaderView.h"
#import "FMTMerchantInfoModel.h"
#import "FMTMerchantInfoListViewModel.h"
#import "MJChiBaoZiHeader.h"
#import "DOPDropDownMenu1.h"

#import "FMTMerchantDetailViewController.h"

typedef NS_ENUM(NSUInteger, FMTHomePageFilterCategory) {
    FMTHomePageFilterCategoryAll,
    FMTHomePageFilterCategoryDistance,
    FMTHomePageFilterCategorySort,
    FMTHomePageFilterCategoryFilter
};

typedef NS_ENUM(NSUInteger, FMTHomePageFilterCategoryAllDetail) {
    FMTHomePageFilterCategoryAllDetailMeishi,
    FMTHomePageFilterCategoryAllDetailTuan,
    FMTHomePageFilterCategoryAllDetailMovie,
    FMTHomePageFilterCategoryAllDetailHotel
};

static NSString *const kTableViewCellIdentifier = @"tableViewCellIdentifier";

static const NSUInteger tableViewHeaderViewHeight = 480.;

@interface FMTHomePageViewController () <UITableViewDelegate, UITableViewDataSource, DOPDropDownMenuDelegate, DOPDropDownMenuDataSource>

@property (nonatomic, strong) FMTHomePageTableHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FMTMerchantInfoListViewModel *merchantInfoListViewModel;
@property (nonatomic, strong) DOPDropDownMenu1 *dropDownMenu;
@property (nonatomic, strong) NSMutableArray<FMTMerchantInfoModel *> *merchantInfoArray;

@property (nonatomic, copy) NSArray<NSString *> *classifys;
@property (nonatomic, copy) NSArray<NSString *> *cates;
@property (nonatomic, copy) NSArray<NSString *> *movices;
@property (nonatomic, copy) NSArray<NSString *> *hostels;
@property (nonatomic, copy) NSArray<NSString *> *areas;
@property (nonatomic, copy) NSArray<NSString *> *sorts;
@property (nonatomic, copy) NSArray<NSString *> *filters;

@end

@implementation FMTHomePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configNavigationBar];

    [self.view addSubview:self.tableView];
    [self configTableViewHeaderAndFooter];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView registerClass:[FMTMerchantInfoListTableViewCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
    
    @weakify(self);
    [self.merchantInfoListViewModel fetchMerchantInfoListWithURL:[NSURL URLWithString:@"XXX"]
                                                           doing:^(id obj) {
                                                               // 在请求中需要做一些事写在这里
                                                           }
                                                         success:^(id obj) {
                                                             // 请求成功后,在这将解析的数据存放在_merchantInfoListArray数组中
                                                             @strongify(self);
                                                             self.merchantInfoArray = nil;
                                                         }
                                                         failure:^(id obj) {
                                                             // 请求失败后可以在这里做一些事
                                                         }];
    
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_footer beginRefreshing];
    
    [self mockMerchantList];
    [self mockFiterData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - setter & getter

- (UITableView *)tableView
{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _tableView;
}

- (FMTHomePageTableHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[FMTHomePageTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tableViewHeaderViewHeight)];
        [_headerView addBorderWithColor:[UIColor lightGrayColor] width:0.5 boderType:UIViewBorderTypeTop];
    }
    
    return _headerView;
}

- (FMTMerchantInfoListViewModel *)merchantInfoListViewModel
{
    if (!_merchantInfoListViewModel) {
        _merchantInfoListViewModel = [[FMTMerchantInfoListViewModel alloc] init];
    }
    
    return _merchantInfoListViewModel;
}

- (NSMutableArray *)merchantInfoArray
{
    if (!_merchantInfoArray) {
        _merchantInfoArray = [NSMutableArray array];
    }
    
    return _merchantInfoArray;
}

- (DOPDropDownMenu1 *)dropDownMenu
{
    if (!_dropDownMenu) {
        _dropDownMenu = [[DOPDropDownMenu1 alloc] initWithOrigin:CGPointMake(0, tableViewHeaderViewHeight) andHeight:44.];
        [_dropDownMenu addBorderWithColor:[UIColor lightGrayColor] width:0.5 boderType:UIViewBorderTypeTop];
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
   
    return _dropDownMenu;
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105.;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.dropDownMenu;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMTMerchantDetailViewController *vc  = [[FMTMerchantDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableviewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.merchantInfoArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMTMerchantInfoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier forIndexPath:indexPath];
    FMTMerchantInfoModel *merchantInfoListModel = [self.merchantInfoArray objectAtIndex:indexPath.row];
    [cell configCellWithMerchantInfoListModel:merchantInfoListModel];
    
    return cell;
}

#pragma mark - helper methods

- (void)configNavigationBar
{
    UISearchBar *searchView = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100., 40.)];
    searchView.placeholder = @"输入商家名、品类或商圈";
    self.navigationItem.titleView = searchView;
    
    UIButton *locationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [locationButton setImage:[UIImage imageNamed:@"map"] forState:UIControlStateNormal];
    [locationButton addTarget:self action:@selector(didClicklocationButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *locationButtonItem = [[UIBarButtonItem alloc] initWithCustomView:locationButton];
    self.navigationItem.rightBarButtonItem = locationButtonItem;
}

- (void)loadMoreData
 {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [self.tableView.mj_footer endRefreshing];
    });
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)configTableViewHeaderAndFooter
{
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

- (void)mockFiterData
{
    self.classifys = @[@"美食",
                       @"今日新单",
                       @"电影",
                       @"酒店"];
    
    self.cates = @[@"自助餐",
                   @"快餐",
                   @"火锅",
                   @"日韩料理",
                   @"西餐",
                   @"烧烤小吃"];
    
    self.movices = @[@"内地剧",
                     @"港台剧",
                     @"英美剧"];
    
    self.hostels = @[@"经济酒店",
                     @"商务酒店",
                     @"连锁酒店",
                     @"度假酒店",
                     @"公寓酒店",
                     @"全城",
                     @"芙蓉区",
                     @"雨花区",
                     @"天心区",
                     @"开福区",
                     @"岳麓区"];
    
    self.areas = @[@"全城",
                   @"芙蓉区",
                   @"雨花区",
                   @"天心区",
                   @"开福区",
                   @"岳麓区"];
    
    self.sorts = @[@"默认排序",
                   @"离我最近",
                   @"好评优先",
                   @"人气优先",
                   @"最新发布"];
    
    self.filters = @[@"全城",
                     @"芙蓉区",
                     @"雨花区",
                     @"天心区",
                     @"开福区",
                     @"岳麓区"];
}

- (void)mockMerchantList {
    
    NSDictionary *dic = @{
                          @"merchantName":@"韩式烤肉（朝阳店）",
                          @"address":@"朝阳区  1.4km",
                          @"category":@"清真菜",
                          @"starLevel":@(6),
                          @"pricePerPerson":@"¥100/人",
                          @"merchantImageURL":[NSNull null],
                          @"otherDescription":@"买单立享9.5折"
                          };
    
    for (NSUInteger i = 0; i < 15; i ++) {
        FMTMerchantInfoModel *model = [[FMTMerchantInfoModel alloc] initWithDic:dic];
        [self.merchantInfoArray addObject:model];
    }
}

#pragma mark - DOPDropDownMenuDataSource

- (NSInteger)menu:(DOPDropDownMenu1 *)menu numberOfRowsInColumn:(NSInteger)column
{
    NSUInteger rows = 0;
    switch (column) {
        case FMTHomePageFilterCategoryAll:
            rows = [self.classifys count];
            break;
        case FMTHomePageFilterCategoryDistance:
            rows = [self.areas count];
            break;
        case FMTHomePageFilterCategorySort:
            rows = [self.sorts count];
            break;
        case FMTHomePageFilterCategoryFilter:
            rows = [self.sorts count];
            break;
    }
    
    return rows;
}

- (NSString *)menu:(DOPDropDownMenu1 *)menu titleForRowAtIndexPath:(DOPIndexPath1 *)indexPath
{
    NSString *title = @"";
    switch (indexPath.column) {
        case FMTHomePageFilterCategoryAll:
            title = self.classifys[indexPath.row];
            break;
        case FMTHomePageFilterCategoryDistance:
            title = self.areas[indexPath.row];
            break;
        case FMTHomePageFilterCategorySort:
            title = self.sorts[indexPath.row];
            break;
        case FMTHomePageFilterCategoryFilter:
            title = self.sorts[indexPath.row];
            break;
    }
    
    return title;
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu1 *)menu
{
    return 4;
}

- (NSString *)menu:(DOPDropDownMenu1 *)menu imageNameForRowAtIndexPath:(DOPIndexPath1 *)indexPath
{
    if (indexPath.column == FMTHomePageFilterCategoryAll || indexPath.column == FMTHomePageFilterCategoryDistance) {
        
        return [NSString stringWithFormat:@"ic_filter_category_%ld", (long)indexPath.row];
    }
    
    return nil;
}

- (NSInteger)menu:(DOPDropDownMenu1 *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column != FMTHomePageFilterCategoryAll) {
        return 0;
    }
    
    if (row == FMTHomePageFilterCategoryAllDetailMeishi) {
        return self.cates.count;
    } else if (row == FMTHomePageFilterCategoryAllDetailMovie) {
        return self.movices.count;
    } else if (row == FMTHomePageFilterCategoryAllDetailHotel) {
        return self.hostels.count;
    } else {
        return 0;
    }
}

- (NSString *)menu:(DOPDropDownMenu1 *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath1 *)indexPath
{
    if (indexPath.column != FMTHomePageFilterCategoryAll) {
        return nil;
    }
    
    if (indexPath.row == FMTHomePageFilterCategoryAllDetailMeishi) {
        return self.cates[indexPath.item];
    } else if (indexPath.row == FMTHomePageFilterCategoryAllDetailMovie) {
        return self.movices[indexPath.item];
    } else if (indexPath.row == FMTHomePageFilterCategoryAllDetailHotel) {
        return self.hostels[indexPath.item];
    } else {
        return nil;
    }
}

- (NSString *)menu:(DOPDropDownMenu1 *)menu detailTextForRowAtIndexPath:(DOPIndexPath1 *)indexPath
{
    if (indexPath.column < 2) {
        return [@(arc4random() % 1000) stringValue];
    }
    
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu1 *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath1 *)indexPath
{
    return [@(arc4random() % 1000) stringValue];
}

#pragma mark - DOPDropDownMenuDelegate

- (void)menu:(DOPDropDownMenu1 *)menu didSelectColumn:(NSInteger)column
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    NSLog(@"I select column--%ld ", (long)column);
}

- (void)menu:(DOPDropDownMenu1 *)menu didSelectRowAtIndexPath:(DOPIndexPath1 *)indexPath
{
    NSLog(@"I select %ld--%ld--%ld ", (long)indexPath.column, (long)indexPath.row, (long)indexPath.item);
}

#pragma mark - button target

- (void)didClicklocationButton
{
    NSLog(@"此处应跳转到地图界面");
}

@end
