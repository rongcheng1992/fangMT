//
//  UIView+Border.h
//  fangMT
//
//  Created by Rong on 2017/5/7.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIViewBorderDirection) {
    UIViewBorderDirectionLeft   = 1 << 0,
    UIViewBorderDirectionRight  = 1 << 1,
    UIViewBorderDirectionTop    = 1 << 2,
    UIViewBorderDirectionBottom = 1 << 3
};

@interface UIView (Border)

- (void)addBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth  boderDirection:(UIViewBorderDirection)direction;

@end
