//
//  HomePageFilterCollectionViewController.m
//  fangMT
//
//  Created by Rong on 2017/5/10.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "HomePageFilterCollectionViewController.h"
#import "HomePageFilterCollectionViewCell.h"
#import "HomePageFilterCollectionViewViewModel.h"
#import "HomePageFilterCollectionViewModel.h"

const static NSString* kCollectionViewCellIdentifier = @"ollectionViewCellIdentifier";

@interface HomePageFilterCollectionViewController()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HomePageFilterCollectionViewViewModel *viewModel;
@property (nonatomic,copy) NSMutableArray *collectionInfoArray;

@end

@implementation HomePageFilterCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[HomePageFilterCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    
    [self.viewModel fetchCollectionInfoWithURL:[NSURL URLWithString:@"XXX"]
                                         Doing:^(id obj) {
                                             // 在请求中需要做一些事写在这里
                                         }
                                       Success:^(id obj) {
                                           // 请求成功后,在这将解析的数据存放在_merchantInfoListArray数组中
                                           _collectionInfoArray = nil;
                                           //                                           _collectionInfoArray = @[
                                           //                                                                    ];
                                       }
                                       Failure:^(id obj) {
                                           // 请求失败后可以在这里做一些事
                                       }];
    [self mockData];

    //[self configHomePageFilterView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.collectionView reloadData];
    
    // do sth
}

- (void)mockData {
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
        HomePageFilterCollectionViewModel *model = [[HomePageFilterCollectionViewModel alloc] initWithDic:dic];
        [self.collectionInfoArray addObject:model];
    }
    
    return ;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //做一些选中事件处理
    NSLog(@"collectionView--%ld--%ld", (long)indexPath.section,(long)indexPath.row);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.collectionInfoArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    
    HomePageFilterCollectionViewModel* model = _collectionInfoArray[indexPath.row];
    [cell configViewWithModel:model];
    
    return cell;
}

#pragma mark - setter & getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(ScreenWidth/4., 100.);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [self.view addSubview:_collectionView];
    }
    
    return _collectionView;
}

- (HomePageFilterCollectionViewViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HomePageFilterCollectionViewViewModel alloc] init];
    }
    
    return _viewModel;
}

- (NSMutableArray *)collectionInfoArray {
    if (!_collectionInfoArray) {
        _collectionInfoArray = [[NSMutableArray alloc ] init];
    }
    
    return _collectionInfoArray;
}

- (void)configFilterViewPositionY:(CGFloat)y Height:(CGFloat)filterViewHeight {
    self.view.frame = CGRectMake(0, 0, ScreenWidth, filterViewHeight);
    self.collectionView.frame = CGRectMake(0, 0, ScreenWidth, filterViewHeight);
}
@end
