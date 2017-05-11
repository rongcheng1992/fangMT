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

- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, ViewHeight - borderWidth, ViewWidth, borderWidth);
    [self.layer addSublayer:border];
}

- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, ViewWidth, borderWidth);
    [self.layer addSublayer:border];
}

- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, borderWidth, ViewHeight);
    [self.layer addSublayer:border];

}

- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(ViewWidth - borderWidth, 0, borderWidth, ViewHeight);
    [self.layer addSublayer:border];
}

@end
