//
//  FilterConditionLineView.m
//  fangMT
//
//  Created by Rong on 2017/5/6.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FilterConditionLineView.h"
#import "FilterConditionView.h"
#import "UIView+Border.h"

#define LineViewHeight 39.0
#define ContainerViewHeight ((_currentTablefilterConditions.count * 44.) < 220.) ? (_currentTablefilterConditions.count * 44.) : 220.

const static NSString *kTableViewCommonCellIdentifier = @"tableViewCommonCellIdentifier";

typedef NS_ENUM(NSUInteger, filterTableType) {
    filterTableTypeZore,
    filterTableTypeOne,
    filterTableTypeTwo,
    filterTableTypeThree
};

@interface FilterConditionLineView()<FilterConditionViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) filterTableType currentFilterTable;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, copy) NSMutableArray *currentTablefilterConditions;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FilterConditionLineView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configLineView];
        self.currentFilterTable = filterTableTypeZore;
    }
    
    return self;
}

#pragma mark - setter & getter

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 260., ScreenWidth, ContainerViewHeight)];
        _containerView.backgroundColor = [UIColor blueColor];
    }

    return _containerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ContainerViewHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCommonCellIdentifier];
    }
    
    return _tableView;
}

- (NSMutableArray *)oneTablefilterConditions {
    if (!_currentTablefilterConditions) {
        _currentTablefilterConditions = [NSMutableArray array];
    }
    
    return _currentTablefilterConditions;
}

- (void)setCurrentFilterTable:(filterTableType)filterTable {
    _currentTablefilterConditions = [_fourCategoryDetailArray objectAtIndex:filterTable];
}

#pragma  mark - helper methods

- (void)configLineView {
    NSUInteger num = [self.fourCategoryArray count];
    CGFloat width = ScreenWidth / num;
    NSUInteger it = 0;
    
    for (NSString* name in self.fourCategoryArray) {
        CGRect rect = CGRectMake(it*width, 0, width, LineViewHeight);
        FilterConditionView *view = [[FilterConditionView alloc] initWithFrame:rect];
        view.conditionName = name;
        view.tag = it;
        [view configViewWithNameString:name];
        view.delegate = self;
        [self addSubview:view];
        
        it++;
    }
    
    [self addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:0.5];
    [self addTopBorderWithColor:[UIColor lightGrayColor] andWidth:0.5];

    self.backgroundColor = [UIColor whiteColor];
    
    return ;
}

#pragma mark - FilterConditionViewDelegate

- (void)clickFilterCondition:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    self.currentFilterTable = button.superview.tag;
    
    if ([_delegate conformsToProtocol:@protocol(FilterConditionLineViewDelegate)]) {
        [_delegate clickFilterButtonWithBlock:^{
            [self.superview addSubview:self.containerView];
            [self.containerView addSubview:self.tableView];

        }];
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44.;
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // todo
    
    NSLog(@"tableView--%ld--%ld",(long)indexPath.section, (long)indexPath.row);
}

#pragma mark - UITableviewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_currentTablefilterConditions count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCommonCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [_currentTablefilterConditions objectAtIndex:indexPath.row];
    
    return cell;
}

@end
