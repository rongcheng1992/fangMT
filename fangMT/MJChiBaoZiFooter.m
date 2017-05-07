//
//  MJChiBaoZiFooter.m
//  fangMT
//
//  Created by Rong on 2017/5/8.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "MJChiBaoZiFooter.h"

@implementation MJChiBaoZiFooter

- (void)prepare {
    [super prepare];
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
