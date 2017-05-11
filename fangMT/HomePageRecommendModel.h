//
//  HomePageRecommendModel.h
//  fangMT
//
//  Created by Rong on 2017/5/10.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageRecommendModel : NSObject

@property (nonatomic, copy) NSString *mainTitle;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *detailDes;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
