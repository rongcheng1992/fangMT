//
//  HomePageTableHeaderCollectionViewCellModel.h
//  fangMT
//
//  Created by Rong on 2017/5/7.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageTableHeaderCollectionViewCellModel : NSObject

@property (nonatomic, copy) NSString* imageName;

@property (nonatomic, copy) NSString* title;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
