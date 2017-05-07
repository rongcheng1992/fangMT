//
//  FilterConditionLineView.h
//  fangMT
//
//  Created by Rong on 2017/5/6.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterConditionLineView : UIView

@property (nonatomic, copy) NSDictionary *conditionsDic;

- (void)configLineViewWithconditionsDic:(NSDictionary *)dic;

@end
