//
//  HomePageFilterCollectionViewModel.m
//  fangMT
//
//  Created by Rong on 2017/5/7.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "HomePageFilterCollectionViewModel.h"

@implementation HomePageFilterCollectionViewModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (dic[@"imageName"]) {
        _imageName = dic[@"imageName"];
    } else {
        _imageName = @"默认";
    }
    
    if (dic[@"title"]) {
        _title = dic[@"title"];
    } else {
        _title = @"默认";
    }
    
    return self;
}

@end
