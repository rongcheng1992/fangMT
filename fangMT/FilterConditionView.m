//
//  FilterConditionView.m
//  fangMT
//
//  Created by Rong on 2017/5/6.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FilterConditionView.h"
#import "Masonry.h"

@interface FilterConditionView()

@property (nonatomic, strong) UIButton *nameButton;

@end

@implementation FilterConditionView

- (instancetype)initWithConditionName:(NSString *)conditionName {
    if (self = [super init]) {
        [self configViewWithNameString:conditionName];
    }
    return self;
}

#pragma mark - setter & getter 

- (void)setConditionName:(NSString *)conditionName {
   // self.nameButton.titleLabel.text = conditionName;
}

#pragma mark - helper method

- (void)configViewWithNameString:(NSString *)name {
    self.nameButton = [[UIButton alloc] init];
    [self.nameButton setTitle:name forState:UIControlStateNormal];
    [self.nameButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.nameButton.titleLabel setFont:[UIFont systemFontOfSize:15.]];
    [self.nameButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
    
    [self addSubview:_nameButton];
    [self addSubview:imageView];
    
    [self.nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(70.);
        make.height.mas_equalTo(39.);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_nameButton.mas_trailing);
        make.top.mas_equalTo(_nameButton.mas_top);
        make.trailing.mas_equalTo(self.mas_trailing);
        make.bottom.mas_equalTo(_nameButton.mas_bottom);
    }];
}

- (void)buttonClicked:(id)sender {
    // 这里需要进行delegate了传给那个FilterConditionLineView来做吧
    
    if ([_delegate conformsToProtocol:@protocol(FilterConditionViewDelegate)]) {
        [_delegate clickFilterCondition:sender];
    }
}

#pragma mark - setter & getter

- (UIButton *)nameButton {
    if (!_nameButton) {
        _nameButton = [[UIButton alloc] init];
    }
    
    return _nameButton;
}


@end
