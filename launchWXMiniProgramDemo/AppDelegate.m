//
//  AppDelegate.m
//  demo
//
//  Created by 韶光荏苒 on 2019/2/22.
//  Copyright © 2019 韶光荏苒. All rights reserved.
//

#import "AppDelegate.h"
#import "ExampleViewController.h"
#import "WeChatSDK/WXApi.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WXApi registerApp:@"wxeef846ed0142011c"];
    
    ExampleViewController *vc = [[ExampleViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self.window setRootViewController:nav];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(nonnull NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    return [WXApi handleOpenURL:url delegate:self];
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

-(void)onReq:(BaseReq *)req{
    NSLog(@"req:%@", req);
}

-(void)onResp:(BaseResp *)resp{
    NSLog(@"resp:%@", resp);
    if([resp isKindOfClass:[WXLaunchMiniProgramResp class]]){
        if (resp.errCode == 0) {
            NSLog(@"WXLaunchMiniProgramResp Success.");
            WXLaunchMiniProgramResp *wxResp = (WXLaunchMiniProgramResp *)resp;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WXResponse" object:wxResp.extMsg];
        }else{
            NSLog(@"WXLaunchMiniProgramResp Fail.");
        }
    }
}

@end
