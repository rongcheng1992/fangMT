//
//  FMTMerchantInfoListModel.h
//  fangMT
//
//  Created by Rong on 2017/5/4.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FMTMerchantStarLevel) {
    FMTMerchantStarLevelZore,
    FMTMerchantStarLevelOne,
    FMTMerchantStarLevelTwo,
    FMTMerchantStarLevelThree,
    FMTMerchantStarLevelFour,
    FMTMerchantStarLevelFive
};

@interface FMTMerchantInfoModel : NSObject

@property (nonatomic, copy) NSString *merchantName;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *otherDescription;
@property (nonatomic, assign) FMTMerchantStarLevel starLevel;
@property (nonatomic, assign) NSString *pricePerPerson;
@property (nonatomic, strong) NSURL *merchantImageURL;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
