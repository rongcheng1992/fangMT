//
//  FilterConditionLineView.m
//  fangMT
//
//  Created by Rong on 2017/5/6.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FilterConditionLineView.h"
#import "FilterConditionView.h"
#import "UIView+Border.h"

#define LineViewHeight 39.0

@interface FilterConditionLineView()<FilterConditionViewDelegate>

@end

@implementation FilterConditionLineView

#pragma mark - setter & getter

- (NSDictionary *)conditionsArray {
    if (!_conditionsDic) {
        _conditionsDic = [NSDictionary dictionary];
    }
    
    return _conditionsDic;
}

#pragma  mark - helper methods

- (void)configLineViewWithconditionsDic:(NSDictionary *)dic {
    NSUInteger num = [dic count];
    CGFloat width = ScreenWidth / num;
    NSUInteger it = 0;
    
    for (NSString* name in dic.allKeys) {
        CGRect rect = CGRectMake(it*width, 0, width, LineViewHeight);
        FilterConditionView *view = [[FilterConditionView alloc] initWithFrame:rect];
        view.conditionName = name;
        [view configViewWithNameString:name];
        view.delegate = self;
        [self addSubview:view];
        
        it++;
    }
    
    [self addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:0.5];
    [self addTopBorderWithColor:[UIColor lightGrayColor] andWidth:0.5];

    self.backgroundColor = [UIColor whiteColor];
    
    return ;
}

#pragma mark - FilterConditionViewDelegate

-(void)clickFilterCondition:(id)sender {
    // 这里是弄到对应的value来对点击后下拉的框框做处理，一般是生成一个tableview
    UIButton *button = (UIButton *)sender;
    NSString *name = button.titleLabel.text;
    NSArray *filters = _conditionsDic[name];
    
    // 先创建一个containerView，用来add下拉框的
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 300., ScreenWidth, ScreenHeight - 330. )];
    containerView.backgroundColor = [UIColor lightGrayColor];
    for (NSString* filter in filters) {
        NSLog(@"下拉的这个view是不是又要代理给add这个LineView那个控制器做啊");
        NSLog(@"%@\n", name);
        
    }
    
    return ;
    
}


@end
