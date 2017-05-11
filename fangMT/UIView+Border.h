//
//  UIView+Border.h
//  fangMT
//
//  Created by Rong on 2017/5/7.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Border)

- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;

- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;

- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;

- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;

@end
