//
//  FMTHomePageRecommendModel.m
//  fangMT
//
//  Created by Rong on 2017/5/10.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FMTHomePageRecommendModel.h"

@implementation FMTHomePageRecommendModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.mainTitle = (dic[@"mainTitle"] && [dic[@"mainTitle"] isKindOfClass:[NSString class]]) ? dic[@"mainTitle"] : @"默认";
        self.subTitle = (dic[@"subTitle"] && [dic[@"subTitle"] isKindOfClass:[NSString class]]) ? dic[@"subTitle"] : @"默认";
        self.imageName = (dic[@"imageName"] && [dic[@"imageName"] isKindOfClass:[NSString class]]) ? dic[@"imageName"] : @"默认";
        self.detailDes = (dic[@"detailDes"] && [dic[@"detailDes"] isKindOfClass:[NSString class]]) ? dic[@"detailDes"] : @"默认";
    }
    
    return self;
}

@end
