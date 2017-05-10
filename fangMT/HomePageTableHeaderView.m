//
//  HomePageTableHeaderView.m
//  fangMT
//
//  Created by Rong on 2017/5/5.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "HomePageTableHeaderView.h"
#import "HomePageFilterCollectionViewController.h"
#import "HomePageRecommendViewController.h"

#define RecommendViewHeight 220.
#define FilterCollectionViewHeight 220.

const static NSString* kCollectionViewCellIdentifier = @"ollectionViewCellIdentifier";

@interface HomePageTableHeaderView()

@property (nonatomic, strong) HomePageFilterCollectionViewController *filterCollectionViewController;
@property (nonatomic, strong) HomePageRecommendViewController *recommendViewController;

@end

@implementation HomePageTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.filterCollectionViewController configFilterViewPositionY:0 Height:FilterCollectionViewHeight];
        [self.recommendViewController configRecommendViewPositionY:FilterCollectionViewHeight + 20.  Height:RecommendViewHeight];
    }
    
    return self;
}

#pragma mark - setter & getter

- (HomePageFilterCollectionViewController *)filterCollectionViewController {
    if (!_filterCollectionViewController) {
        _filterCollectionViewController = [[HomePageFilterCollectionViewController alloc] init];
        [ self addSubview:_filterCollectionViewController.view];
    }
    
    return _filterCollectionViewController;
}

- (HomePageRecommendViewController *)recommendViewController {
    if (!_recommendViewController) {
        _recommendViewController = [[HomePageRecommendViewController alloc] init];
        [ self addSubview:_recommendViewController.view];
    }
    
    return _recommendViewController;
}

@end
