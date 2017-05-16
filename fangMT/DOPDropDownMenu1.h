//
//  DOPDropDownMenu.h
//  DOPDropDownMenuDemo
//
//  Created by weizhou on 9/26/14.
//  Modify by tanyang on 20/3/15.
//  Copyright (c) 2014 fengweizhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOPIndexPath1 : NSObject

@property (nonatomic, assign) NSInteger column;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger item;

- (instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row;
+ (instancetype)indexPathWithCol:(NSInteger)col row:(NSInteger)row;
+ (instancetype)indexPathWithCol:(NSInteger)col row:(NSInteger)row item:(NSInteger)item;

@end

@interface DOPBackgroundCellView1 : UIView

@end

#pragma mark - data source protocol
@class DOPDropDownMenu1;

@protocol DOPDropDownMenuDataSource <NSObject>

@required

/**
 *  返回 menu 第column列有多少行
 */
- (NSInteger)menu:(DOPDropDownMenu1 *)menu numberOfRowsInColumn:(NSInteger)column;

/**
 *  返回 menu 第column列 每行title
 */
- (NSString *)menu:(DOPDropDownMenu1 *)menu titleForRowAtIndexPath:(DOPIndexPath1 *)indexPath;

@optional

/**
 *  返回 menu 有多少列 ，默认1列
 */
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu1 *)menu;

/** 新增
 *  新增 返回 menu 第column列 每行image
 *  如果都没有可以不实现该协议
 */
- (NSString *)menu:(DOPDropDownMenu1 *)menu imageNameForRowAtIndexPath:(DOPIndexPath1 *)indexPath;

/** 新增
 *  新增 detailText ,right text
 *  如果都没有可以不实现该协议
 */
- (NSString *)menu:(DOPDropDownMenu1 *)menu detailTextForRowAtIndexPath:(DOPIndexPath1 *)indexPath;

/** 新增
 *  当有column列 row 行 返回有多少个item ，如果>0，说明有二级列表 ，=0 没有二级列表
 *  如果都没有可以不实现该协议
 */
- (NSInteger)menu:(DOPDropDownMenu1 *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column;

/** 新增
 *  当有column列 row 行 item项 title
 *  如果都没有可以不实现该协议
 */
- (NSString *)menu:(DOPDropDownMenu1 *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath1 *)indexPath;

/** 新增
 *  当有column列 row 行 item项 image
 *  如果都没有可以不实现该协议
 */
- (NSString *)menu:(DOPDropDownMenu1 *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath1 *)indexPath;

/** 新增
 *  当有column列 row 行 item项 detailDescription
 *  如果都没有可以不实现该协议
 */
- (NSString *)menu:(DOPDropDownMenu1 *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath1 *)indexPath;

@end

#pragma mark - delegate
@protocol DOPDropDownMenuDelegate <NSObject>
@optional

/**
 *  点击代理，点击了第column
 */
- (void)menu:(DOPDropDownMenu1 *)menu didSelectColumn:(NSInteger)column;

/**
 *  点击代理，点击了第column 第row 或者item项，如果 item >=0
 */
- (void)menu:(DOPDropDownMenu1 *)menu didSelectRowAtIndexPath:(DOPIndexPath1 *)indexPath;

/** 新增
 *  return nil if you don't want to user select specified indexpath
 *  optional
 */
- (NSIndexPath *)menu:(DOPDropDownMenu1 *)menu willSelectRowAtIndexPath:(DOPIndexPath1 *)indexPath;

@end

#pragma mark - interface
@interface DOPDropDownMenu1 : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <DOPDropDownMenuDataSource> dataSource;
@property (nonatomic, weak) id <DOPDropDownMenuDelegate> delegate;

@property (nonatomic, assign) UITableViewCellStyle cellStyle; // default value1
@property (nonatomic, strong) UIColor *indicatorColor;      // 三角指示器颜色
@property (nonatomic, strong) UIColor *textColor;           // 文字title颜色
@property (nonatomic, strong) UIColor *textSelectedColor;   // 文字title选中颜色
@property (nonatomic, strong) UIColor *detailTextColor;     // detailText文字颜色
@property (nonatomic, strong) UIFont *detailTextFont;       // font
@property (nonatomic, strong) UIColor *separatorColor;      // 分割线颜色
@property (nonatomic, assign) NSInteger fontSize;           // 字体大小

// 当有二级列表item时，点击row 是否调用点击代理方法
@property (nonatomic, assign) BOOL isClickHaveItemValid;

@property (nonatomic, getter=isRemainMenuTitle) BOOL remainMenuTitle; // 切换条件时是否更改menu title
@property (nonatomic, strong) NSMutableArray *currentSelectRowArray; // 恢复默认选项用

@property (nonatomic, copy) void (^popWillShowBlock)();
@property (nonatomic, copy) void (^popWillHideBlock)();

/**
 *  the width of menu will be set to screen width defaultly
 *
 *  @param origin the origin of this view's frame
 *  @param height menu's height
 *
 *  @return menu
 */
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;

/**
 *获取title
 *@param indexPath 路径
 *@return 返回indexPath所在title
*/
- (NSString *)titleForRowAtIndexPath:(DOPIndexPath1 *)indexPath;

/**
 重新加载数据
 */
- (void)reloadData;


/**
 创建menu 第一次显示 不会调用点击代理，这个手动调用
 */
- (void)selectDefalutIndexPath;


/**
 默认trigger delegate
 */
- (void)selectIndexPath:(DOPIndexPath1 *)indexPath; 


/**
 调用代理
 */
- (void)selectIndexPath:(DOPIndexPath1 *)indexPath triggerDelegate:(BOOL)trigger; //

@end
