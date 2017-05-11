//
//  HomePageRecommendViewController.m
//  fangMT
//
//  Created by Rong on 2017/5/10.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "HomePageRecommendViewController.h"
#import "HomePageRecommendViewModel.h"
#import "HomePageRecommendModel.h"
#import "HomePageRecommendViewCell.h"
#import "UIView+Border.h"

@interface HomePageRecommendViewController ()

@property (nonatomic, strong) HomePageRecommendViewModel *viewModel;
@property (nonatomic, copy) NSMutableArray *recommendInfoArray;

@end

@implementation HomePageRecommendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.viewModel fetchRecommendInfoWithURL:[NSURL URLWithString:@"XXX"]
                                         Doing:^(id obj) {
                                             // 在请求中需要做一些事写在这里
                                         }
                                       Success:^(id obj) {
                                           // 请求成功后,在这将解析的数据存放在_merchantInfoListArray数组中
                                           _recommendInfoArray = nil;
                                           //                                           _recommendInfoArray = @[
                                           //                                                                    ];
                                       }
                                       Failure:^(id obj) {
                                           // 请求失败后可以在这里做一些事
                                       }];
    [self mockData];
    
    [self configRecommendView];
}

#pragma mark - getter

- (NSMutableArray *)recommendInfoArray
{
    if (!_recommendInfoArray) {
        _recommendInfoArray = [NSMutableArray array];
    }
    
    return _recommendInfoArray;
}

#pragma mark - helper method

- (void)configRecommendView
{
    BOOL flip = NO;
    for (NSUInteger i = 0; i < _recommendInfoArray.count; i ++) {
        CGRect rect;

        // 第一行 这里面的数字最好不要直接写上
        if (!flip) {
            if (i == 0) {
                rect = CGRectMake(0, 0, ScreenWidth / 2., 220.);
            } else {
                rect = CGRectMake(ScreenWidth / 2. + (i - 1) * ScreenWidth / 4.,  0, ScreenWidth / 4., 110.);
                
                flip = (i == 2) ? !flip : flip;
            }
        } else { // 第二行
            rect = CGRectMake(ScreenWidth / 2. + (i - 3) * ScreenWidth / 4., 110., ScreenWidth / 4., 110.);
        }

        HomePageRecommendViewCell *cell = [[HomePageRecommendViewCell alloc] initWithFrame:rect];
        
        [cell addTopBorderWithColor:[UIColor lightGrayColor] andWidth:0.5];
        [cell addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:0.5];
        [cell addLeftBorderWithColor:[UIColor lightGrayColor] andWidth:0.5];
        [cell addRightBorderWithColor:[UIColor lightGrayColor] andWidth:0.5];

        cell.isPositonMiddle = i;
        
        HomePageRecommendViewModel *model = [_recommendInfoArray objectAtIndex:i];
        [cell configViewWithModel:model];
        
        [self.view addSubview:cell];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)mockData
{
    NSArray *array = @[@{@"mainTitle":@"名店特惠",
                         @"subTitle":@"优质商家精选",
                         @"imageName":@"recommend0",
                         @"detailDes":@"超值特惠"},
                       @{@"mainTitle":@"24.9封顶",
                         @"subTitle":@"吃饱又好吃",
                         @"imageName":@"recommend1",
                         @"detailDes":@""},
                       @{@"mainTitle":@"5月当红热卖",
                         @"subTitle":@"吃一口就上瘾",
                         @"imageName":@"recommend2",
                         @"detailDes":@""},
                       @{@"mainTitle":@"美食排行榜",
                         @"subTitle":@"\"食\"在不一般",
                         @"imageName":@"recommend3",
                         @"detailDes":@""},
                       @{@"mainTitle":@"未吃的好店",
                         @"subTitle":@"优惠尝鲜",
                         @"imageName":@"recommend4",
                         @"detailDes":@""}];
    
    for (NSDictionary *dic in array) {
        HomePageRecommendModel *model = [[HomePageRecommendModel alloc] initWithDic:dic];
        [self.recommendInfoArray addObject:model];
    }
    
    return ;
}

- (void)configRecommendViewPositionY:(CGFloat)y Height:(CGFloat)recommendViewHeight
{
    self.view.frame = CGRectMake(0, y, ScreenWidth, recommendViewHeight);
}

@end
