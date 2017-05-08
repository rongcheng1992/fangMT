//
//  MerchantInfoListTableViewCell.m
//  fangMT
//
//  Created by Rong on 2017/5/4.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "MerchantInfoListTableViewCell.h"
#import "MerchantInfoListModel.h"
#import "Masonry.h"

typedef NS_ENUM(NSUInteger, starLevel) {
    starLevelZore,
    starLevelOne,
    starLevelTwo,
    starLevelThree,
    starLevelFour,
    starLevelFive
};

@interface MerchantInfoListTableViewCell()

@property (nonatomic, strong) UIImageView *merchantImageView;
@property (nonatomic, strong) UILabel *merchantNameLabel;
@property (nonatomic, strong) UIImageView *starLevelImageView;
@property (nonatomic, strong) UILabel *pricePerPersonLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) UIView *seperatorLine;
@property (nonatomic, strong) UILabel *otherDescriptionLabel;

@end

@implementation MerchantInfoListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // cell的页面布局
        [self setupView];
    }
    
    return self;
}

- (void)ConfigCellWithMerchantInfoListModel:(MerchantInfoListModel *)model {
    // 没有考虑存在个别model属性为空的情况
    self.merchantImageView.image = [UIImage imageNamed:[NSString stringWithContentsOfURL:model.merchantImageURL encoding:nil error:nil]];
    self.merchantNameLabel.text = model.merchantName;
    
    UIImage *starImage = [self starImageForLevel:model.starLevel];
    self.starLevelImageView.image = !starImage ? [UIImage imageNamed:@"默认"] : starImage;
    
    self.pricePerPersonLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.pricePerPerson];
    self.addressLabel.text = model.address;
    self.categoryLabel.text = model.category;
    self.otherDescriptionLabel.text = model.otherDescription;
}

#pragma mark - helper method

- (void)setupView {
    
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
    
    // 需要在加约束之前调用addSubview
    [self.contentView addSubview:_merchantImageView];
    [self.contentView addSubview:_merchantNameLabel];
    [self.contentView addSubview:_starLevelImageView];
    [self.contentView addSubview:_addressLabel];
    [self.contentView addSubview:_pricePerPersonLabel];
    [self.contentView addSubview:_otherDescriptionLabel];
    [self.contentView addSubview:_seperatorLine];
    
    // 增加约束关系
    [_merchantImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.leading.equalTo(self.contentView.mas_leading).offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [_merchantNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_merchantImageView.mas_top);
        make.leading.equalTo(_merchantImageView.mas_trailing).offset(10);
        make.trailing.equalTo(self.contentView.mas_trailing);
    }];
    
    [_starLevelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_merchantNameLabel.mas_bottom).offset(10);
        make.leading.equalTo(_merchantNameLabel.mas_leading);
        make.width.mas_equalTo(80.);
        make.height.mas_equalTo(20.);
    }];
    
    [_pricePerPersonLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_starLevelImageView.mas_top);
        make.leading.equalTo(_starLevelImageView.mas_trailing).offset(10);
    }];
    
    [_starLevelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_merchantNameLabel.mas_height);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_starLevelImageView.mas_top);
        make.leading.equalTo(_pricePerPersonLabel.mas_trailing).offset(10);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-10.);
    }];
    
    [_seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_starLevelImageView.mas_bottom).offset(15);
        make.leading.equalTo(_starLevelImageView.mas_leading);
        make.width.mas_equalTo(ScreenWidth - 40);
        make.height.mas_equalTo(0.25);
    }];
    
    [_otherDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_seperatorLine.mas_bottom).offset(5);
        make.leading.equalTo(_seperatorLine.mas_leading);
    }];

}

- (UIImage *)starImageForLevel:(NSUInteger)level {
    UIImage *image = nil;
    switch (level) {
        case starLevelZore:
            // image =
            break;
        case starLevelOne:
            // image =
            break;
        case starLevelTwo:
            // image =
            break;
        case starLevelThree:
            // image =
            break;
        case starLevelFour:
            // image =
            break;
        case starLevelFive:
            // image =
            break;
        default:
            // image =
            break;
    }
    
    return  image;
}

@end
