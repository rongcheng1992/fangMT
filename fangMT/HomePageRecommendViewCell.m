//
//  HomePageRecommendViewCell.m
//  fangMT
//
//  Created by Rong on 2017/5/10.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "HomePageRecommendViewCell.h"
#import "HomePageRecommendModel.h"
#import "Masonry.h"

@interface HomePageRecommendViewCell()

@property (nonatomic, strong) UILabel *mainTitleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HomePageRecommendViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    
    return self;
}

- (void)configViewWithModel:(HomePageRecommendModel *)model
{
    // 没有考虑存在个别model属性为空的情况
    NSTextAlignment alignment = _isPositonMiddle ? NSTextAlignmentCenter : NSTextAlignmentLeft;
    
    self.imageView.image = [UIImage imageNamed:model.imageName];
    self.mainTitleLabel.text = model.mainTitle;
    self.mainTitleLabel.textAlignment =  alignment;

    self.desLabel.text = model.detailDes;
    
    self.subTitleLabel.text = model.subTitle;
    self.subTitleLabel.textAlignment =  alignment;
    
    // 增加约束关系
    [_mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.mas_top).offset(5.);
        make.leading.equalTo(self.mas_leading).offset(10.);
        make.trailing.equalTo(self.mas_trailing).offset(-10);
        make.height.mas_equalTo(20.);
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_mainTitleLabel.mas_bottom).offset(5.);
        make.leading.equalTo(_mainTitleLabel.mas_leading);
        make.trailing.equalTo(_mainTitleLabel.mas_trailing);
        make.height.mas_equalTo(15.);
    }];
    
    if (!_isPositonMiddle) {
        [_desLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_subTitleLabel.mas_bottom).offset(5.);
            make.leading.equalTo(_subTitleLabel.mas_leading);
            make.trailing.equalTo(_subTitleLabel.mas_trailing);
            make.height.mas_equalTo(20.);
        }];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_desLabel.mas_bottom).offset(15.);
            make.leading.equalTo(_mainTitleLabel.mas_leading);
            make.trailing.equalTo(_mainTitleLabel.mas_trailing);
            make.bottom.equalTo(self.mas_bottom).offset(-10.);
        }];
    } else {
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_subTitleLabel.mas_bottom).offset(5.);
            make.leading.equalTo(_mainTitleLabel.mas_leading);
            make.trailing.equalTo(_mainTitleLabel.mas_trailing);
            make.bottom.equalTo(self.mas_bottom).offset(-5.);
        }];
    }
}

#pragma mark - helper method

- (void)setupView
{
    // 图片
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.image = [UIImage imageNamed:@"image"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    // mainTitleLabel
    self.mainTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.mainTitleLabel.text = @"--";
    self.mainTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.mainTitleLabel setFont:[UIFont boldSystemFontOfSize:14.]];
    
    // subTitleLabel
    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subTitleLabel.text = @"--";
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.subTitleLabel setFont:[UIFont systemFontOfSize:11.]];
    [self.subTitleLabel setTextColor:[UIColor grayColor]];
    
    // DesLabel
    if (!_isPositonMiddle) {
        self.desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.desLabel.text = _isPositonMiddle ? @"" : @"--";
        self.desLabel.textAlignment = NSTextAlignmentLeft;
        [self.desLabel setFont:[UIFont systemFontOfSize:11.]];
        [self.desLabel setTextColor:[UIColor grayColor]];
        
        [self addSubview:_desLabel];
    }
    
    // 需要在加约束之前调用addSubview
    [self addSubview:_imageView];
    [self addSubview:_mainTitleLabel];
    [self addSubview:_subTitleLabel];
}

@end
