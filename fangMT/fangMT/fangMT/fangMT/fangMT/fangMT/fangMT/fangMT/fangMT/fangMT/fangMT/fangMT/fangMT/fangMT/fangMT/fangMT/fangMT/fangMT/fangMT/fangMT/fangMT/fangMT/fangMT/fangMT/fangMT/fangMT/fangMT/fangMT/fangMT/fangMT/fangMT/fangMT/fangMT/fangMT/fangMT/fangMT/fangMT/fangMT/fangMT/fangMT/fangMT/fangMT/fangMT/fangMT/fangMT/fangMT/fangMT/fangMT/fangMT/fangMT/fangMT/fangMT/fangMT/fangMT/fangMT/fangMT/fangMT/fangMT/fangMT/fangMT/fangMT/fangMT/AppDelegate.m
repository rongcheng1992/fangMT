//
//  AppDelegate.m
//  fangMT
//
//  Created by Rong on 2017/5/3.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) HomePageViewController *homePageViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIButton *cityButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    cityButton.titleLabel.font = [UIFont systemFontOfSize:14];
    cityButton.backgroundColor = [UIColor redColor];
    [cityButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cityButton addTarget:self action:@selector(didClickCityButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cityButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cityButton];
//    UIBarButtonItem *leftSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    leftSpaceItem.width = 2;
    self.homePageViewController.navigationItem.rightBarButtonItem = cityButtonItem;
    //@[leftSpaceItem, cityButtonItem];
//    self.homePageViewController. = ;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.homePageViewController];
    
    self.window.rootViewController = navigationController;
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - setter & getter

- (HomePageViewController *)homePageViewController {
    if (!_homePageViewController) {
        _homePageViewController = [[HomePageViewController alloc] init];
    }
    
    return _homePageViewController;
}


@end
