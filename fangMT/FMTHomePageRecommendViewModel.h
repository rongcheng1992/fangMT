//
//  FMTHomePageRecommendViewModel.h
//  fangMT
//
//  Created by Rong on 2017/5/10.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMTHomePageRecommendViewModel : NSObject

typedef void (^doingBlcok)(id obj);
typedef void (^successBlcok)(id obj);
typedef void (^failureBlcok)(id obj);

- (void)fetchRecommendInfoWithURL:(NSURL *)url
                            doing:(doingBlcok)doingBlcok
                          success:(successBlcok)successBlcok
                          failure:(failureBlcok)failureBlcok;

@end
