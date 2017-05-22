//
//  UIView+Border.h
//  fangMT
//
//  Created by Rong on 2017/5/7.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIViewBorderType) {
    UIViewBorderTypeLeft   = 1 << 0,
    UIViewBorderTypeRight  = 1 << 1,
    UIViewBorderTypeTop    = 1 << 2,
    UIViewBorderTypeBottom = 1 << 3
};

@interface UIView (Border)

- (void)addBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth boderType:(UIViewBorderType)type;

@end
