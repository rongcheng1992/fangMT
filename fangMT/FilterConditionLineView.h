//
//  FilterConditionLineView.h
//  fangMT
//
//  Created by Rong on 2017/5/6.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  FilterConditionLineViewDelegate<NSObject>

@required
- (void)clickFilterButtonWithBlock:(void (^)(void))block;

@end

@interface FilterConditionLineView : UIView

@property (nonatomic, weak) id<FilterConditionLineViewDelegate> delegate;

@property (nonatomic, copy) NSMutableArray *fourCategoryArray;

@property (nonatomic, copy) NSMutableArray *fourCategoryDetailArray;

- (void)configLineView;

@end


