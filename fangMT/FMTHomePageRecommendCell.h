//
//  FMTHomePageRecommendCell.h
//  fangMT
//
//  Created by Rong on 2017/5/10.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FMTHomePageRecommendModel;

@interface FMTHomePageRecommendCell : UIView

@property (nonatomic, assign) BOOL isPositonMiddle;

- (void)configViewWithModel:(FMTHomePageRecommendModel *)model;

@end
