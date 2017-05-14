//
//  FMTMerchantInfoModel.m
//  fangMT
//
//  Created by Rong on 2017/5/4.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FMTMerchantInfoModel.h"

@implementation FMTMerchantInfoModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.merchantImageURL = (dic[@"merchantImageURL"] && [dic[@"merchantImageURL"] isKindOfClass:[NSURL class]]) ? dic[@"imageName"] : [[NSURL alloc] initWithString:@"pizza"];
        self.starLevel = dic[@"starLevel"] ? [dic[@"starLevel"] integerValue] : StarLevelZore;
        self.merchantName = (dic[@"merchantName"] && [dic[@"merchantName"] isKindOfClass:[NSString class]]) ? dic[@"merchantName"] : @"默认";
        self.pricePerPerson = (dic[@"pricePerPerson"]  && [dic[@"pricePerPerson"] isKindOfClass:[NSString class]]) ? dic[@"pricePerPerson"] : @"默认";
        self.address = (dic[@"address"] && [dic[@"address"] isKindOfClass:[NSString class]]) ? dic[@"address"] : @"默认";
        self.category = (dic[@"category"] && [dic[@"category"] isKindOfClass:[NSString class]]) ? dic[@"category"] : @"默认";
        self.otherDescription = (dic[@"otherDescription"] && [dic[@"otherDescription"] isKindOfClass:[NSString class]]) ? dic[@"otherDescription"] : @"默认";
    }
    
    return self;
}

@end
