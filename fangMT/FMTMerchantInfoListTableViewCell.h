//
//  MerchantInfoListTableViewCell.h
//  fangMT
//
//  Created by Rong on 2017/5/4.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMTMerchantInfoModel;

@interface FMTMerchantInfoListTableViewCell : UITableViewCell

- (void)configCellWithMerchantInfoListModel:(FMTMerchantInfoModel *)model;

@end
