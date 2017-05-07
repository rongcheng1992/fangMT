//
//  HomePageTableHeaderCollectionViewCell.m
//  fangMT
//
//  Created by Rong on 2017/5/7.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "HomePageTableHeaderCollectionViewCell.h"
#import "HomePageTableHeaderCollectionViewCellModel.h"
#import "Masonry.h"

@interface HomePageTableHeaderCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HomePageTableHeaderCollectionViewCell

- (void)configViewWithModel:(HomePageTableHeaderCollectionViewCellModel *)model {
    // 没有考虑存在个别model属性为空的情况
    self.imageView.image = [UIImage imageNamed:model.imageName];
    self.titleLabel.text = model.title;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    
    return self;
}

#pragma mark - helper method

- (void)setupView {
    
    // 图片
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.image = [UIImage imageNamed:@"image"];
    
    // title
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = @"XX";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // 需要在加约束之前调用addSubview
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_titleLabel];
   
    // 增加约束关系
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.leading.equalTo(self.contentView.mas_leading);
        make.width.mas_equalTo(ScreenWidth/4.0);
        make.height.mas_equalTo(80.);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_imageView.mas_bottom).offset(5.);
        make.leading.equalTo(_imageView.mas_leading);
        make.trailing.equalTo(_imageView.mas_trailing);
    }];
}

@end