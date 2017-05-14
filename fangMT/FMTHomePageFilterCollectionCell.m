//
//  FMTHomePageFilterCollectionCell.m
//  fangMT
//
//  Created by Rong on 2017/5/7.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FMTHomePageFilterCollectionCell.h"
#import "FMTHomePageFilterCollectionModel.h"

@interface FMTHomePageFilterCollectionCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation FMTHomePageFilterCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    
    return self;
}

- (void)configViewWithModel:(FMTHomePageFilterCollectionModel *)model
{
    self.imageView.image = [UIImage imageNamed:model.imageName];
    self.titleLabel.text = model.title;
}

#pragma mark - helper method

- (void)setupView
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.image = [UIImage imageNamed:@"image"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = @"XX";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel setFont:[UIFont systemFontOfSize:13.]];
    [self.titleLabel setTextColor:[UIColor grayColor]];
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
   
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.leading.equalTo(self.contentView.mas_leading);
        make.width.mas_equalTo(SCREEN_WIDTH/4.);
        make.height.mas_equalTo(80.);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.imageView.mas_bottom).offset(5.);
        make.leading.equalTo(self.imageView.mas_leading);
        make.trailing.equalTo(self.imageView.mas_trailing);
    }];
}

@end
