//
//  AppDelegate.m
//  Pirate
//
//  Created by ios－08 on 15/8/10.
//  Copyright (c) 2015年 ios－08. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSData *serializeddata;
    NSError *error;
    
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    MasterViewController *masterController = (MasterViewController *)nav.topViewController;
    
    serializeddata = [NSPropertyListSerialization dataWithPropertyList:[masterController.products copy] format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    
    if (serializeddata) {
        NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [NSString stringWithFormat:@"%@/serialized.xml",[docPath objectAtIndex:0]];
        [serializeddata writeToFile:docDir atomically:YES];
    }
    
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
