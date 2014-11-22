//
//  AppDelegate.m
//  scrollDev
//
//  Created by goshan on 11/22/14.
//  Copyright (c) 2014 goshan. All rights reserved.
//

#import "AppDelegate.h"
#import "GHCategoryMenuController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSMutableArray *listDate = [[NSMutableArray alloc] init];
    for (int i=0; i<6; i++){
        UIViewController *viewController = [[UIViewController alloc] init];
        viewController.view.frame = CGRectMake(0.0, 0.0, 320.0, 546.0);
        viewController.title = [NSString stringWithFormat:@"goshan%d", i];
        viewController.view.backgroundColor = [UIColor grayColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 100.0, 100.0, 50.0)];
        label.text = viewController.title;
        label.textColor = [UIColor blueColor];
        
        [viewController.view addSubview:label];
        [listDate addObject:viewController];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    GHCategoryMenuController *rootController = [[GHCategoryMenuController alloc] initWithFrame:self.window.bounds andMenuHeight:50.0f];
    rootController.listDate = listDate;
    self.window.rootViewController = rootController;
    [self.window addSubview:rootController.view];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
