//
//  FMTHomePageRecommendViewController.m
//  fangMT
//
//  Created by Rong on 2017/5/10.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FMTHomePageRecommendViewController.h"
#import "FMTHomePageRecommendViewModel.h"
#import "FMTHomePageRecommendModel.h"
#import "FMTHomePageRecommendCell.h"

@interface FMTHomePageRecommendViewController ()

@property (nonatomic, strong) FMTHomePageRecommendViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *recommendInfoArray;

@end

@implementation FMTHomePageRecommendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    [self.viewModel fetchRecommendInfoWithURL:[NSURL URLWithString:@"XXX"]
                                         doing:^(id obj) {
                                             // 在请求中需要做一些事写在这里
                                         }
                                       success:^(id obj) {
                                           // 请求成功后,在这将解析的数据存放在_merchantInfoListArray数组中
                                           @strongify(self);
                                           self.recommendInfoArray = nil;
                                       }
                                       failure:^(id obj) {
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
    for (NSUInteger i = 0; i < self.recommendInfoArray.count; i ++) {
        CGRect rect;

        // TODO:去掉数字
        if (!flip) {
            if (i == 0) {
                rect = CGRectMake(0, 0, SCREEN_WIDTH / 2., 220.);
            } else {
                rect = CGRectMake(SCREEN_WIDTH / 2. + (i - 1) * SCREEN_WIDTH / 4.,  0, SCREEN_WIDTH / 4., 110.);
                
                flip = (i == 2) ? !flip : flip;
            }
        } else {
            // 第二行
            rect = CGRectMake(SCREEN_WIDTH / 2. + (i - 3) * SCREEN_WIDTH / 4., 110., SCREEN_WIDTH / 4., 110.);
        }
        
        FMTHomePageRecommendCell *cell = [[FMTHomePageRecommendCell alloc] initWithFrame:rect];
        [cell addBorderWithColor:[UIColor lightGrayColor] width:0.5 boderDirection:UIViewBorderDirectionTop | UIViewBorderDirectionBottom | UIViewBorderDirectionLeft | UIViewBorderDirectionRight];

        cell.isPositonMiddle = i;
        
        FMTHomePageRecommendModel *model = [self.recommendInfoArray objectAtIndex:i];
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
        FMTHomePageRecommendModel *model = [[FMTHomePageRecommendModel alloc] initWithDic:dic];
        [self.recommendInfoArray addObject:model];
    }
    
    return ;
}

- (void)configRecommendViewPositionY:(CGFloat)y height:(CGFloat)recommendViewHeight
{
    self.view.frame = CGRectMake(0, y, SCREEN_WIDTH, recommendViewHeight);
}

@end
