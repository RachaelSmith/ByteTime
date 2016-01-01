//
//  AppDelegate.m
//  ByteTime1
//
//  Created by Rachael Smith on 12/2/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Parse setApplicationId:@"viT9Ls8dscj80OYjrntLbHt5Um7dfkShKG65iD1C" clientKey:@"586lsc1zDKMlMuF5BBVdnZV3ZAZ5OjjEVd5VOHui"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // set the background for the navigation bar
    UIImage *navBackgroundImage = [UIImage imageNamed:@"NavBarCorrect2.png"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    // customize text for navbar
    // NSShadow *shadow = [[NSShadow alloc] init];
    // shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    // shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:0x52/255.0f green:0x16/255.0f blue:0x70/255.0f alpha:1], NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-Thin" size:21.0], NSFontAttributeName, nil]];
    
    // change back buttons to white
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // change font of bar buttons
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f], NSFontAttributeName,
                                                          nil]forState:UIControlStateNormal];
    
    
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
