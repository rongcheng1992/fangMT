//
//  MJChiBaoZiHeader.m
//  fangMT
//
//  Created by Rong on 2017/5/8.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "MJChiBaoZiHeader.h"

@implementation MJChiBaoZiHeader

- (void)prepare
{
    [super prepare];
    
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i < 61; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    
    [self setImages:idleImages forState:MJRefreshStateIdle];
 
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
