//
//  MerchantInfoListModel.m
//  fangMT
//
//  Created by Rong on 2017/5/4.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "MerchantInfoListModel.h"

@interface MerchantInfoListModel()

@end

@implementation MerchantInfoListModel

/**
 dic {
   merchantImageURL: @"",
       merchantName: @"",
          starLevel: @(),
     pricePerPerson: @(),
            address: @"",
           category: @"",
   otherDescription: @""
 }
 */
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (dic[@"merchantImageURL"]) {
        _merchantImageURL = dic[@"merchantImageURL"];
    } else {
        _merchantImageURL = [[NSURL alloc] initWithString:@"默认"];
    }
    
    if (dic[@"merchantName"]) {
        _merchantName = dic[@"merchantName"];
    } else {
        _merchantName = @"默认";
    }
    
    if (dic[@"starLevel"]) {
        _starLevel = [dic[@"starLevel"] integerValue];
    } else {
        _starLevel = 0;
    }
    
    if (dic[@"pricePerPerson"]) {
        _pricePerPerson = [dic[@"pricePerPerson"] integerValue];
    } else {
        _pricePerPerson = 0;
    }

    if (dic[@"address"]) {
        _address = dic[@"address"];
    } else {
        _address = @"默认";
    }

    if (dic[@"category"]) {
        _category = dic[@"category"];
    } else {
        _category = @"默认";
    }

    if (dic[@"otherDescription"]) {
        _otherDescription = dic[@"otherDescription"];
    } else {
        _otherDescription = @"默认";
    }
    
    return self;
}

@end
