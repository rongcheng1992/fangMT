//
//  FMTHomePageTableHeaderView.m
//  fangMT
//
//  Created by Rong on 2017/5/5.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FMTHomePageTableHeaderView.h"
#import "FMTHomePageFilterCollectionViewController.h"
#import "FMTHomePageRecommendViewController.h"

static const NSInteger RecommendViewHeight = 220.;
static const NSInteger FilterCollectionViewHeight = 220.;

static const NSString *kCollectionViewCellIdentifier = @"kCollectionViewCellIdentifier";

@interface FMTHomePageTableHeaderView()

@property (nonatomic, strong) FMTHomePageFilterCollectionViewController *filterCollectionViewController;
@property (nonatomic, strong) FMTHomePageRecommendViewController *recommendViewController;

@end

@implementation FMTHomePageTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.filterCollectionViewController configFilterViewPositionY:0 height:FilterCollectionViewHeight];
        [self addSubview:self.filterCollectionViewController.view];
        
        [self.recommendViewController configRecommendViewPositionY:FilterCollectionViewHeight + 20. height:RecommendViewHeight];
        [self addSubview:self.recommendViewController.view];
    }
    
    return self;
}

#pragma mark - setter & getter

- (FMTHomePageFilterCollectionViewController *)filterCollectionViewController
{
    if (!_filterCollectionViewController) {
        _filterCollectionViewController = [[FMTHomePageFilterCollectionViewController alloc] init];
    }
    
    return _filterCollectionViewController;
}

- (FMTHomePageRecommendViewController *)recommendViewController
{
    if (!_recommendViewController) {
        _recommendViewController = [[FMTHomePageRecommendViewController alloc] init];
    }
    
    return _recommendViewController;
}

@end
