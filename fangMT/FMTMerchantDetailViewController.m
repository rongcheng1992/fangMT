//
//  FMTMerchantDetailViewController.m
//  fangMT
//
//  Created by Rong on 2017/5/16.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "FMTMerchantDetailViewController.h"

@interface FMTMerchantDetailViewController ()

@end

@implementation FMTMerchantDetailViewController

- (void)loadView {
    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    test.backgroundColor = [UIColor greenColor];
    self.view = test;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
