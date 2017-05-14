//
//  AppDelegate.m
//  fangMT
//
//  Created by Rong on 2017/5/3.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "AppDelegate.h"
#import "FMTHomePageViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) FMTHomePageViewController *homePageViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.homePageViewController];
    self.window.rootViewController = navigationController;

    return YES;
}

#pragma mark - setter & getter

- (FMTHomePageViewController *)homePageViewController
{
    if (!_homePageViewController) {
        _homePageViewController = [[FMTHomePageViewController alloc] init];
    }
    
    return _homePageViewController;
}

@end
