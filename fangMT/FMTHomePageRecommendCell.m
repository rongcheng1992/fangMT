//
//  FMTHomePageRecommendCell.m
//  fangMT
//
//  Created by Rong on 2017/5/10.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FMTHomePageRecommendCell.h"
#import "FMTHomePageRecommendModel.h"

@interface FMTHomePageRecommendCell()

@property (nonatomic, strong) UILabel *mainTitleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation FMTHomePageRecommendCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    
    return self;
}

- (void)configViewWithModel:(FMTHomePageRecommendModel *)model
{
    NSTextAlignment alignment = self.isPositonMiddle ? NSTextAlignmentCenter : NSTextAlignmentLeft;
    
    self.imageView.image = [UIImage imageNamed:model.imageName];
    self.mainTitleLabel.text = model.mainTitle;
    self.mainTitleLabel.textAlignment = alignment;
    self.desLabel.text = model.detailDes;
    self.subTitleLabel.text = model.subTitle;
    self.subTitleLabel.textAlignment = alignment;
    
    // 更新约束
    if (self.isPositonMiddle) {
        self.desLabel.hidden = YES;
//        [self.desLabel mas_remakeConstraints:^(MASConstraintMaker *make){
//            make.height.mas_equalTo(0.01);
//        }];
        
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.subTitleLabel.mas_bottom).offset(5.);
            make.leading.equalTo(self.mainTitleLabel.mas_leading);
            make.trailing.equalTo(self.mainTitleLabel.mas_trailing);
            make.bottom.equalTo(self.mas_bottom).offset(-5.);
        }];
    }
}

#pragma mark - helper method

- (void)setupView
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.image = [UIImage imageNamed:@"image"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.mainTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.mainTitleLabel.text = @"--";
    self.mainTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.mainTitleLabel setFont:[UIFont boldSystemFontOfSize:13.]];
    
    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subTitleLabel.text = @"--";
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.subTitleLabel setFont:[UIFont systemFontOfSize:11.]];
    [self.subTitleLabel setTextColor:[UIColor grayColor]];
    
    if (!_isPositonMiddle) {
        self.desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.desLabel.text = _isPositonMiddle ? @"" : @"--";
        self.desLabel.textAlignment = NSTextAlignmentLeft;
        [self.desLabel setFont:[UIFont systemFontOfSize:11.]];
        [self.desLabel setTextColor:[UIColor grayColor]];
        
        [self addSubview:self.desLabel];
    }
    
    [self addSubview:self.imageView];
    [self addSubview:self.mainTitleLabel];
    [self addSubview:self.subTitleLabel];
    
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.mas_top).offset(5.);
        make.leading.equalTo(self.mas_leading).offset(10.);
        make.trailing.equalTo(self.mas_trailing).offset(-10);
        make.height.mas_equalTo(20.);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.mainTitleLabel.mas_bottom).offset(5.);
        make.leading.equalTo(self.mainTitleLabel.mas_leading);
        make.trailing.equalTo(self.mainTitleLabel.mas_trailing);
        make.height.mas_equalTo(15.);
    }];
    
    if (!self.isPositonMiddle) {
        [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.subTitleLabel.mas_bottom).offset(5.);
            make.leading.equalTo(self.subTitleLabel.mas_leading);
            make.trailing.equalTo(self.subTitleLabel.mas_trailing);
            make.height.mas_equalTo(20.);
        }];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.desLabel.mas_bottom).offset(15.);
            make.leading.equalTo(self.mainTitleLabel.mas_leading);
            make.trailing.equalTo(self.mainTitleLabel.mas_trailing);
            make.bottom.equalTo(self.mas_bottom).offset(-10.);
        }];
    } else {
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.subTitleLabel.mas_bottom).offset(5.);
            make.leading.equalTo(self.mainTitleLabel.mas_leading);
            make.trailing.equalTo(self.mainTitleLabel.mas_trailing);
            make.bottom.equalTo(self.mas_bottom).offset(-5.);
        }];
    }
}

@end
