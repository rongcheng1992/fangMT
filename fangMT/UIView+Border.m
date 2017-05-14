//
//  UIView+Border.m
//  fangMT
//
//  Created by Rong on 2017/5/7.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "UIView+Border.h"

#define ViewHeight self.frame.size.height
#define ViewWidth self.frame.size.width

@implementation UIView (Border)

- (void)addBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth  boderDirection:(UIViewBorderDirection)direction {
    if (direction & UIViewBorderDirectionTop) {
        [self addTopBorderWithColor:color width:borderWidth];
    }
    
    if (direction & UIViewBorderDirectionBottom) {
        [self addBottomBorderWithColor:color width:borderWidth];
    }
    
    if (direction & UIViewBorderDirectionLeft) {
        [self addLeftBorderWithColor:color width:borderWidth];
    }
    
    if (direction & UIViewBorderDirectionRight) {
        [self addRightBorderWithColor:color width:borderWidth];
    }
}

- (void)addBottomBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, ViewHeight - borderWidth, ViewWidth, borderWidth);
    [self.layer addSublayer:border];
}

- (void)addTopBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, ViewWidth, borderWidth);
    [self.layer addSublayer:border];
}

- (void)addLeftBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, borderWidth, ViewHeight);
    [self.layer addSublayer:border];

}

- (void)addRightBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(ViewWidth - borderWidth, 0, borderWidth, ViewHeight);
    [self.layer addSublayer:border];
}

@end
