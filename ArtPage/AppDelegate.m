//
//  AppDelegate.m
//  ArtPage
//
//  Created by 华杉科技 on 2018/9/20.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "WeiboSDK.h"

#import "LoginViewController.h"
#import "ColumnViewController.h"
#import "DownloadViewController.h"

@interface AppDelegate ()

@property (assign, nonatomic) UIBackgroundTaskIdentifier bgTask;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //向微信注册
    [WXApi registerApp:@"wx4868b35061f87885" withDescription:@"artPage 2.0"];
    //像微博注册
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:@"2045436852"];
    
    //免登陆
    if(getUD(@"UserID"))
    {
        ColumnViewController *vc = [[ColumnViewController alloc] init];
        vc.isPublic = @"YES";
        _nav = [[ArtNavigationController alloc] initWithRootViewController:vc];
    }
    else{
        LoginViewController *vc = [[LoginViewController alloc] init];
        _nav = [[ArtNavigationController alloc] initWithRootViewController:vc];
    }
    //设置软件的默认状态
    if(!getUD(@"语言"))
        setUD(@"中文", @"语言");
    if(!getUD(@"publicWorkIsShow"))
        setUD(@"YES", @"publicWorkIsShow");
    if(!getUD(@"nonPublicWorkIsShow"))
        setUD(@"YES", @"nonPublicWorkIsShow");
    if(!getUD(@"newsIsShow"))
        setUD(@"YES", @"newsIsShow");
    if(!getUD(@"aboutIsShow"))
        setUD(@"YES", @"aboutIsShow");
        
        
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = _nav;
    [_window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    __weak typeof(self) weakSelf = self;
    UIApplication *app = [UIApplication sharedApplication];
    _bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        // 每个对 beginBackgroundTaskWithExpirationHandler:方法的调用,必须要相应的调用 endBackgroundTask:方法。这样，来告诉应用程序你已经执行完成了。也就是说,我们向 iOS 要更多时间来完成一个任务,那么我们必须告诉 iOS 你什么时候能完成那个任务。
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [app endBackgroundTask:self.bgTask];
            weakSelf.bgTask = UIBackgroundTaskInvalid;
        });
    }];

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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if(!url)
    {
        return NO;
    }
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if(!url)
    {
        return NO;
    }
    return YES;
}



@end













