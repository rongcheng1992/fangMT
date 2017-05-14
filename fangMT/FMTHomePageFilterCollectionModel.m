//
//  FMTHomePageFilterCollectionModel.m
//  fangMT
//
//  Created by Rong on 2017/5/7.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FMTHomePageFilterCollectionModel.h"

@implementation FMTHomePageFilterCollectionModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.imageName = (dic[@"imageName"] && [dic[@"imageName"] isKindOfClass:[NSString class]]) ? dic[@"imageName"] : @"默认";
        self.title = (dic[@"title"] && [dic[@"title"] isKindOfClass:[NSString class]]) ? dic[@"title"] : @"默认";
    }
    
    return self;
}

@end
