//
//  HomePageRecommendViewCell.h
//  fangMT
//
//  Created by Rong on 2017/5/10.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageRecommendViewModel;

@interface HomePageRecommendViewCell : UIView

@property (nonatomic, assign)BOOL isPositonMiddle;

- (void)configViewWithModel:(HomePageRecommendViewModel *)model;

@end
