//
//  HomePageTableHeaderCollectionViewCell.h
//  fangMT
//
//  Created by Rong on 2017/5/7.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomePageFilterCollectionViewModel;

@interface HomePageFilterCollectionViewCell : UICollectionViewCell

- (void)configViewWithModel:(HomePageFilterCollectionViewModel *)model;

@end
