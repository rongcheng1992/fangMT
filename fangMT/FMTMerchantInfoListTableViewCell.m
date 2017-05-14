//
//  FMTMerchantInfoListTableViewCell.m
//  fangMT
//
//  Created by Rong on 2017/5/4.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FMTMerchantInfoListTableViewCell.h"
#import "FMTMerchantInfoModel.h"

@interface FMTMerchantInfoListTableViewCell()

@property (nonatomic, strong) UIImageView *merchantImageView;
@property (nonatomic, strong) UILabel *merchantNameLabel;
@property (nonatomic, strong) UIImageView *starLevelImageView;
@property (nonatomic, strong) UILabel *pricePerPersonLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) UIView *seperatorLine;
@property (nonatomic, strong) UILabel *otherDescriptionLabel;

@end

@implementation FMTMerchantInfoListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    
    return self;
}

- (void)configCellWithMerchantInfoListModel:(FMTMerchantInfoModel *)model
{
    self.merchantNameLabel.text = model.merchantName;
    
    UIImage *starImage = [self starImageForLevel:model.starLevel];
    self.starLevelImageView.image = (!starImage) ? [UIImage imageNamed:@"star"] : starImage;
    
    self.pricePerPersonLabel.text = [NSString stringWithFormat:@"%@", model.pricePerPerson];
    self.addressLabel.text = model.address;
    self.categoryLabel.text = model.category;
    self.otherDescriptionLabel.text = model.otherDescription;
}

#pragma mark - helper method

- (void)setupView
{
    // 商家图片
    self.merchantImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.merchantImageView.image = [UIImage imageNamed:@"pizza"];
    
    // 店名
    self.merchantNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.merchantNameLabel.text = @"韩式烤肉（朝阳店）";
   
    // 等级图片
    self.starLevelImageView = [[UIImageView alloc] init];
    self.starLevelImageView.image = [UIImage imageNamed:@"star"];
    
    // 人均价格描述
    self.pricePerPersonLabel = [[UILabel alloc] init];
    self.pricePerPersonLabel.text = @"¥100/人";
    [self.pricePerPersonLabel setTextColor:[UIColor grayColor]];
    [self.pricePerPersonLabel setFont:[UIFont systemFontOfSize:14.]];
    
    // 店地址
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.text = @"朝阳区  1.4km";
    [self.addressLabel setTextColor:[UIColor grayColor]];
    [self.addressLabel setFont:[UIFont systemFontOfSize:14.]];

    // 菜系
    self.categoryLabel = [[UILabel alloc] init];
    self.categoryLabel.text = @"清真菜";
    [self.categoryLabel setTextColor:[UIColor grayColor]];
    [self.categoryLabel setFont:[UIFont systemFontOfSize:14.]];
    
    // cell中的分割线
    self.seperatorLine = [[UIView alloc] init];
    self.seperatorLine.backgroundColor = [UIColor lightGrayColor];
    
    // 其他描述
    self.otherDescriptionLabel = [[UILabel alloc] init];
    self.otherDescriptionLabel.text = @"买单立享9.5折";
    [self.otherDescriptionLabel setTextColor:[UIColor grayColor]];
    [self.otherDescriptionLabel setFont:[UIFont systemFontOfSize:14.]];
    
    [self.contentView addSubview:self.merchantImageView];
    [self.contentView addSubview:self.merchantNameLabel];
    [self.contentView addSubview:self.starLevelImageView];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.pricePerPersonLabel];
    [self.contentView addSubview:self.otherDescriptionLabel];
    [self.contentView addSubview:self.seperatorLine];
    
    [self.merchantImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.leading.equalTo(self.contentView.mas_leading).offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [self.merchantNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.merchantImageView.mas_top);
        make.leading.equalTo(self.merchantImageView.mas_trailing).offset(10);
        make.trailing.equalTo(self.contentView.mas_trailing);
    }];
    
    [self.starLevelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.merchantNameLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.merchantNameLabel.mas_leading);
        make.width.mas_equalTo(80.);
        make.height.mas_equalTo(20.);
    }];
    
    [self.pricePerPersonLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.starLevelImageView.mas_top);
        make.leading.equalTo(self.starLevelImageView.mas_trailing).offset(10);
    }];
    
    [self.starLevelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.merchantNameLabel.mas_height);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.starLevelImageView.mas_top);
        make.leading.equalTo(self.pricePerPersonLabel.mas_trailing).offset(10);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-10.);
    }];
    
    [self.seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.starLevelImageView.mas_bottom).offset(15);
        make.leading.equalTo(self.starLevelImageView.mas_leading);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(0.25);
    }];
    
    [self.otherDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seperatorLine.mas_bottom).offset(5);
        make.leading.equalTo(self.seperatorLine.mas_leading);
    }];
}

- (UIImage *)starImageForLevel:(NSUInteger)level {
    UIImage *image = nil;
    switch (level) {
        case StarLevelZore:
            // image =
            break;
        case StarLevelOne:
            // image =
            break;
        case StarLevelTwo:
            // image =
            break;
        case StarLevelThree:
            // image =
            break;
        case StarLevelFour:
            // image =
            break;
        case StarLevelFive:
            // image =
            break;
    }
    
    return  image;
}

@end
