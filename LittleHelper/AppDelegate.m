//
//  AppDelegate.m
//  LittleHelper
//
//  Created by hexuren on 17/8/24.
//  Copyright © 2017年 hexuren. All rights reserved.
//

#import "AppDelegate.h"
#import "EAIntroView.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "RDVTabBarController+CenterButton.h"
#import "iAppInfos.h"
#import "HRNavigationController.h"
#import "HomeViewController.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>


#define JPushAppKey            @"361b256a592ced20d571b4b5"
#define JPushChannel            @"AppStore"


@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 启动图片延时: 1秒
//        [NSThread sleepForTimeInterval:1];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [self showTabViewControllersAnimated:NO];
    [self.window makeKeyAndVisible];

    //1.在target-capabilities-background modes 开启 audio and airplay
    //2.获取后台播放权限
    NSError* error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    
    [self registerJPushWithOption:launchOptions];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    //后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
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
    //清除所有通知(包含本地通知)
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

#pragma mark - UtilityMethod

- (void)showTabViewControllersAnimated:(BOOL)animate{
    RDVTabBarController *tabBarController = [self configureTabBarController];
    tabBarController.selectedIndex = 0;
    if (animate) {
        UIView *overlayView = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
        [tabBarController.view addSubview:overlayView];
        self.window.rootViewController = tabBarController;
        [UIView animateWithDuration:0.65 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            overlayView.alpha = 0;
        } completion:^(BOOL finished) {
            [overlayView removeFromSuperview];
        }];
    }
    else{
        self.window.rootViewController = tabBarController;
        //        HomeTableViewController *vc = [HomeTableViewController new];
        //        HRNavigationController *navVC = [[HRNavigationController alloc] initWithRootViewController:vc];
        //        self.window.rootViewController = navVC;
    }
}

- (RDVTabBarController *)configureTabBarController{
    RDVTabBarController *tabBarController = [RDVTabBarController new];
    //    tabBarController.delegate = self;
    //    tabBarController.tabBar.height = 47;
    //
    //    UINavigationController *firstNavVC = nil;
    //    NSString *firstTitle = nil;
    //    firstTitle = @"欢迎收听";
    //    HomeViewController *freeclassVC = [HomeViewController new];
    //    firstNavVC = [[UINavigationController alloc] initWithRootViewController:freeclassVC];
    //    firstNavVC.navigationBar.barTintColor = gMainColor;
    //    [tabBarController setViewControllers:@[firstNavVC]];
    
    tabBarController.delegate = self;
    tabBarController.tabBar.height = 0.01;
    HRNavigationController *firstNavVC = nil;
    NSString *firstTitle = nil;
    firstTitle = @"欢迎收听";
    HomeViewController *freeclassVC = [HomeViewController new];
    firstNavVC = [[HRNavigationController alloc] initWithRootViewController:freeclassVC];
    firstNavVC.navigationBar.barTintColor = [UIColor whiteColor];
    
    HRNavigationController *secondNavVC = nil;
    NSString *secondTitle = nil;
    secondTitle = @"新闻";
    HomeViewController *secondVC = [HomeViewController new];
    secondNavVC = [[HRNavigationController alloc] initWithRootViewController:secondVC];
    secondNavVC.navigationBar.barTintColor = gMainColor;
    
    
    HRNavigationController *thirdNavVC = nil;
    NSString *thirdTitle = nil;
    thirdTitle = @"综合";
    HomeViewController *thirdVC = [HomeViewController new];
    thirdNavVC = [[HRNavigationController alloc] initWithRootViewController:thirdVC];
    thirdNavVC.navigationBar.barTintColor = gMainColor;
    
    [tabBarController setViewControllers:@[firstNavVC]];
    
    
    NSArray *title = @[firstTitle,secondTitle,thirdTitle];
    
    NSString *secondImageTitle = @"bottom_contact";
    NSString *thirdImageTitle = @"bottom_application";
    if (IsParent_APP) {
        secondImageTitle = @"bottom_kids";
        thirdImageTitle = @"bottom_find";
    }
    NSArray *imageNames = @[@"bottom_message", secondImageTitle,thirdImageTitle,@"bottom_mine"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        //        if (index == 0) {
        //            NSInteger unread = [[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
        //            if (unread > 0) {
        //                item.badgeValue = [NSString stringWithFormat:@"%ld", unread];
        //            }
        //            else{
        //                item.badgeValue = nil;
        //            }
        //        }
        item.title = title[index];
        item.tintColor = gTextColorMain;
        item.selectedTitleAttributes = @{NSForegroundColorAttributeName : gMainColor,
                                         NSFontAttributeName : gFontSub12};
        item.unselectedTitleAttributes = @{NSForegroundColorAttributeName : gTextColorMain,
                                           NSFontAttributeName : gFontSub12};
        NSString *fileName = imageNames[index];
        
        UIImage *normalImage = [UIImage imageNamed:fileName];
        UIImage *selectedImage = [UIImage imageNamed:[fileName stringByAppendingString:@"_on"]];
        item.titlePositionAdjustment = UIOffsetMake(0, 5);
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
        
        index ++;
    }
    
    return tabBarController;
}


- (void)registerJPushWithOption:(NSDictionary *)launchOptions{
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:JPushChannel
                 apsForProduction:1
            advertisingIdentifier:advertisingId];
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}

#pragma mark - RDVTabBarControllerDelegate

//- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
//    if (index == 4) {
//
//    }
//    return YES;
//}

#pragma mark - JPUSHRegisterDelegate

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService handleRemoteNotification:userInfo];
}

@end
