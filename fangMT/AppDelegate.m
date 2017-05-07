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
    
    UIButton *locationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    locationButton.titleLabel.font = [UIFont systemFontOfSize:14];
    locationButton.backgroundColor = [UIColor redColor];
    [locationButton setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    [locationButton addTarget:self action:@selector(didClicklocationButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *locationButtonItem = [[UIBarButtonItem alloc] initWithCustomView:locationButton];
    self.homePageViewController.navigationItem.rightBarButtonItem = locationButtonItem;

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.homePageViewController];
    self.window.rootViewController = navigationController;

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

#pragma mark -- button target

- (void)didClicklocationButton {
    NSLog(@"此处应跳转到地图界面");
}

@end
