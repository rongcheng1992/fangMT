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

const static NSString *kTableViewCellIdentifier = @"tableViewCellIdentifier";

@interface HomePageViewController ()<UITableViewDelegate, UITableViewDataSource>

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

    [self.tableView registerClass:[MerchantInfoListTableViewCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
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
        NSDictionary *conditionsDic = @{
                                        @"全部":@[@"甜点饮品",@"生日蛋糕",@"火锅",@"自助餐",@"小吃快餐",@"日韩料理",@"西餐",@"聚餐宴请"],
                                        @"附近":@[@"1千米",@"3千米",@"5千米",@"10千米",@"全城"],
                                        @"智能排序":@[@"离我最近",@"好评优先",@"人气最高"],
                                        @"筛选":@[@"1千米",@"3千米",@"5千米",@"10千米",@"全城"]
                                        };
        _filterConditionLineView.conditionsDic = conditionsDic;
        [_filterConditionLineView configLineViewWithconditionsDic:conditionsDic];
    }
    
    return _filterConditionLineView;
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 110.;
    
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

@end
