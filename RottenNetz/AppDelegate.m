//
//  AppDelegate.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "AppDelegate.h"
#import "UserListController.h"
#import "User.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    User * user1 = [[User alloc] init];
    user1.name = @"Peter";
    user1.tracks = [[NSMutableArray alloc] initWithObjects:@"DUMMY", nil];
    
    User * user2 = [[User alloc] init];
    user2.name = @"Heinz";
    user2.tracks = [[NSMutableArray alloc] initWithObjects:@"DUMMY", @"DUMMY2", nil];
    
    NSMutableArray * users = [[NSMutableArray alloc] initWithObjects: user1, user2, nil];
    
    UITabBarController * tbc = (UITabBarController *) self.window.rootViewController;
    UINavigationController * nc = [[tbc viewControllers] objectAtIndex:1];
    UserListController * ulc = [[nc viewControllers] objectAtIndex:0];
    ulc.users = users;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
