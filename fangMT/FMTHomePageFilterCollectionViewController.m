//
//  FMTHomePageFilterCollectionViewController.m
//  fangMT
//
//  Created by Rong on 2017/5/10.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FMTHomePageFilterCollectionViewController.h"
#import "FMTHomePageFilterCollectionCell.h"
#import "FMTHomePageFilterCollectionViewModel.h"
#import "FMTHomePageFilterCollectionModel.h"

static NSString *const kCollectionViewCellIdentifier = @"kCollectionViewCellIdentifier";

@interface FMTHomePageFilterCollectionViewController() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) FMTHomePageFilterCollectionViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray<FMTHomePageFilterCollectionModel *> *collectionInfoArray;

@end

@implementation FMTHomePageFilterCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[FMTHomePageFilterCollectionCell class] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    
    @weakify(self);
    [self.viewModel fetchCollectionInfoWithURL:[NSURL URLWithString:@"XXX"]
                                         doing:^(id obj) {
                                             // 在请求中需要做一些事写在这里
                                         }
                                       success:^(id obj) {
                                           @strongify(self);
                                           self.collectionInfoArray = nil;
                                       }
                                       failure:^(id obj) {
                                           // 请求失败后可以在这里做一些事
                                       }];
    [self mockData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.collectionView reloadData];
}

- (void)mockData
{
    
    NSArray *array = @[@{@"imageName":@"image1",
                         @"title":@"小吃快餐"},
                       @{@"imageName":@"image2",
                         @"title":@"烧烤烤肉"},
                       @{@"imageName":@"image3",
                         @"title":@"预约订座"},
                       @{@"imageName":@"image4",
                         @"title":@"外卖"},
                       @{@"imageName":@"image5",
                         @"title":@"自助餐"},
                       @{@"imageName":@"image6",
                         @"title":@"火锅"},
                       @{@"imageName":@"image7",
                         @"title":@"川湘菜"},
                       @{@"imageName":@"image8",
                         @"title":@"北京菜"}];
    
    for (NSDictionary *dic in array) {
        FMTHomePageFilterCollectionModel *model = [[FMTHomePageFilterCollectionModel alloc] initWithDic:dic];
        [self.collectionInfoArray addObject:model];
    }
    
    return ;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"collectionView--%ld--%ld", (long)indexPath.section,(long)indexPath.row);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectionInfoArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FMTHomePageFilterCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    
    FMTHomePageFilterCollectionModel* model = self.collectionInfoArray[indexPath.row];
    [cell configViewWithModel:model];
    
    return cell;
}

#pragma mark - setter & getter

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/4., 100.);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    
    return _collectionView;
}

- (FMTHomePageFilterCollectionViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[FMTHomePageFilterCollectionViewModel alloc] init];
    }
    
    return _viewModel;
}

- (NSMutableArray *)collectionInfoArray
{
    if (!_collectionInfoArray) {
        _collectionInfoArray = [[NSMutableArray alloc ] init];
    }
    
    return _collectionInfoArray;
}

- (void)configFilterViewPositionY:(CGFloat)y height:(CGFloat)filterViewHeight
{
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, filterViewHeight);
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, filterViewHeight);
}

@end
