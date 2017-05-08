//
//  HomePageTableHeaderView.m
//  fangMT
//
//  Created by Rong on 2017/5/5.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "HomePageTableHeaderView.h"
#import "HomePageTableHeaderCollectionViewCell.h"
#import "HomePageTableHeaderCollectionViewCellViewModel.h"
#import "HomePageTableHeaderCollectionViewCellModel.h"

const static NSString* kCollectionViewCellIdentifier = @"ollectionViewCellIdentifier";

@interface HomePageTableHeaderView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HomePageTableHeaderCollectionViewCellViewModel *viewModel;

@property (nonatomic,copy) NSMutableArray *collectionInfoArray;


@end

@implementation HomePageTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.collectionView registerClass:[HomePageTableHeaderCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    }
    
    return self;
}

- (void)configHomePageTableHeaderView {
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
    [self.collectionView reloadData];
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
        HomePageTableHeaderCollectionViewCellModel *model = [[HomePageTableHeaderCollectionViewCellModel alloc] initWithDic:dic];
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
    HomePageTableHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    
    HomePageTableHeaderCollectionViewCellModel* model = _collectionInfoArray[indexPath.row];
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
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [self addSubview:_collectionView];
    }
    
    return _collectionView;
}

- (HomePageTableHeaderCollectionViewCellViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HomePageTableHeaderCollectionViewCellViewModel alloc] init];
    }
    
    return _viewModel;
}

- (NSMutableArray *)collectionInfoArray {
    if (!_collectionInfoArray) {
        _collectionInfoArray = [[NSMutableArray alloc ] init];
    }
    
    return _collectionInfoArray;
}

@end
