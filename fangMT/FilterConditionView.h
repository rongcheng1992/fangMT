//
//  FilterConditionView.h
//  fangMT
//
//  Created by Rong on 2017/5/6.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterConditionViewDelegate <NSObject>

@required

- (void)clickFilterCondition:(id)sender;

@end

@interface FilterConditionView : UIView

@property (nonatomic, copy) NSString *conditionName;

@property (nonatomic, weak) id<FilterConditionViewDelegate> delegate;

- (void)configViewWithNameString:(NSString *)name;

@end

