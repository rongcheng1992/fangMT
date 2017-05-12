//
//  HomePageRecommendModel.m
//  fangMT
//
//  Created by Rong on 2017/5/10.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "HomePageRecommendModel.h"

@implementation HomePageRecommendModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        if (dic[@"mainTitle"]) {
            _mainTitle = dic[@"mainTitle"];
        } else {
            _mainTitle = @"默认";
        }
        
        if (dic[@"subTitle"]) {
            _subTitle = dic[@"subTitle"];
        } else {
            _subTitle = @"默认";
        }
        
        if (dic[@"imageName"]) {
            _imageName = dic[@"imageName"];
        } else {
            _imageName = @"默认";
        }
        
        if (dic[@"detailDes"]) {
            _detailDes = dic[@"detailDes"];
        } else {
            _detailDes = nil;
        }
    }
    
    return self;
}

@end
