//
//  HomePageFilterCollectionViewViewModel.h
//  fangMT
//
//  Created by Rong on 2017/5/7.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageFilterCollectionViewViewModel : NSObject

typedef void (^doingBlcok)(id obj);
typedef void (^successBlcok)(id obj);
typedef void (^failureBlcok)(id obj);

- (void)fetchCollectionInfoWithURL:(NSURL *)url
                             Doing:(doingBlcok)doingBlcok
                           Success:(successBlcok)successBlcok
                           Failure:(failureBlcok)failureBlcok;

@end
