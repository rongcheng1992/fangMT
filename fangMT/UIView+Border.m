//
//  UIView+Border.m
//  fangMT
//
//  Created by Rong on 2017/5/7.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "UIView+Border.h"
#import "Masonry.h"

#define VIEWHEIGHT self.frame.size.height
#define VIEWWIDTH self.frame.size.width

@implementation UIView (Border)

#pragma mark -- public methods

- (void)addBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth boderType:(UIViewBorderType)type {
    if (type & UIViewBorderTypeTop) {
        [self addTopBorderWithColor:color width:borderWidth];
    }
    
    if (type & UIViewBorderTypeBottom) {
        [self addBottomBorderWithColor:color width:borderWidth];
    }
    
    if (type & UIViewBorderTypeLeft) {
        [self addLeftBorderWithColor:color width:borderWidth];
    }
    
    if (type & UIViewBorderTypeRight) {
        [self addRightBorderWithColor:color width:borderWidth];
    }
}

#pragma mark -- private methods

- (void)addBottomBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.leading.equalTo(self.mas_leading);
        make.trailing.equalTo(self.mas_trailing);
        make.height.mas_equalTo(borderWidth);
    }];
}

- (void)addTopBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.leading.equalTo(self.mas_leading);
        make.trailing.equalTo(self.mas_trailing);
        make.height.mas_equalTo(borderWidth);
    }];
}

- (void)addLeftBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.leading.equalTo(self.mas_leading);
        make.top.equalTo(self.mas_top);
        make.width.mas_equalTo(borderWidth);
    }];
}

- (void)addRightBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.mas_top);
        make.trailing.equalTo(self.mas_trailing);
        make.width.mas_equalTo(borderWidth);
    }];
}

@end
