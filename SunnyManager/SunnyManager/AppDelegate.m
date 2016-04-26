//
//  AppDelegate.m
//  SunnyManager
//
//  Created by mfwl on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVC.h"
#import "HomePageVC.h"
#import "MessagePageVC.h"
#import "MoreOptionPageVC.h"
#import "UMessage.h"

@interface AppDelegate () <LoginVCDelegate>

@property (nonatomic, strong) LoginVC *loginPage;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [UMessage startWithAppkey:@"your appkey" launchOptions:launchOptions];
    
    [self judgeFirstPage];
    return YES;
}


/* 判断是否第一次运行 */
- (void)judgeFirstPage {
    /* NSUserDefaults轻型存储工具, 用于存储一个字符串并判断引导页是否出现 */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults stringForKey:@"FirstLogin"] isEqualToString:@"NO"]) {
        NSDictionary *dic =  (NSDictionary *)[defaults dictionaryForKey:@"userInfoRecord"] ;
        [self gotoMainPageWith:dic];
    } else {
        /* 添加根试图7.0之后没有根试图程序无法运行 */
        self.loginPage = [LoginVC sharedManager];
        _loginPage.delegate = self;
        self.window.rootViewController = self.loginPage;
    }
}


- (void)loginWith:(NSDictionary *)dic {
    [self gotoMainPageWith:dic];
}

- (void)gotoMainPageWith:(NSDictionary *)dic {
    HomePageVC *home = [[HomePageVC alloc] init];
    home.titleName = dic[@"shopname"];
    home.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"主页" image:[UIImage imageNamed:@"home"] selectedImage:[UIImage imageNamed:@"homes"]];
    UINavigationController *homeNC = [[UINavigationController alloc] initWithRootViewController:home];
    
    MessagePageVC *message = [[MessagePageVC alloc] init];
    /* 给首页VC添加视图管理器 */
    message.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"message"] selectedImage:[UIImage imageNamed:@"messages"]];
    UINavigationController *messageNC = [[UINavigationController alloc] initWithRootViewController:message];
    
    /* 创建搭配页面 */
    MoreOptionPageVC *more = [[MoreOptionPageVC  alloc] init];;
    more.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:[UIImage imageNamed:@"more"] selectedImage:[UIImage imageNamed:@"mores"]];
    UINavigationController *moreNC = [[UINavigationController alloc] initWithRootViewController:more];
    
    /* 创建本地页面 */
    UITabBarController *mainTab = [[UITabBarController alloc] init];
    mainTab.viewControllers = @[homeNC, messageNC, moreNC];
    mainTab.tabBar.tintColor = k_Color_Nav;
    self.window.rootViewController = mainTab;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [UMessage registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
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
