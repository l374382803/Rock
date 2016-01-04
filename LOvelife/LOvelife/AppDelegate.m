//
//  AppDelegate.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/29.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "GuidePageVIew.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
//支持QQ
#import "UMSocialQQHandler.h"
//支持微信
#import "UMSocialWechatHandler.h"
//支持新浪
#import "UMSocialSinaHandler.h"

@interface AppDelegate ()

@property(nonatomic,strong) MyTabBarViewController * myTabBar;
@property(nonatomic,strong) GuidePageVIew * guidePageView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //实例化
    self.myTabBar = [[MyTabBarViewController alloc]init];
    LeftViewController * leftVC = [[LeftViewController alloc]init];
    
    MMDrawerController * drawerVC = [[MMDrawerController alloc]initWithCenterViewController:self.myTabBar leftDrawerViewController:leftVC];
    //设置抽屉打开和关闭的模式
    drawerVC.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawerVC.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    //设置左页面打开之后的宽度
    drawerVC.maximumLeftDrawerWidth = SCREEN_W - 100;
    
    self.window.rootViewController = drawerVC;
    
    //修改状态栏的颜色（第二种方式）
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    //添加引导页
    [self createGuidePage];
    //注册友盟分享
    [self addUMShare];
    return YES;
}

#pragma mark - 添加友盟分享
-(void)addUMShare
{
    //注册友盟分享
    [UMSocialData setAppKey:APPKEY];
    //设置QQ的appid，appkey和url
    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@"MnGtpPN5AiB6MNvj" url:nil];
    //设置微信的appid，appSecret和url
    [UMSocialWechatHandler setWXAppId:@"wx12b249bcbf753e87" appSecret:@"0a9cd00c48ee47a9b23119086bcd3b30" url:nil];
    //打开微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    
    //隐藏未安装的客户端(这一步主要针对的是财大气粗的QQ跟微信)
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
}

#pragma mark - 创建引导页
-(void)createGuidePage
{
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"isRuned"]boolValue]) {
        
        NSArray * imageArray = @[@"welcome6",@"welcome7",@"welcome4"];
        self.guidePageView = [[GuidePageVIew alloc]initWithFrame:self.window.bounds ImageArray:imageArray];
        [self.myTabBar.view addSubview:self.guidePageView];
        
        //第一次运行完成之后进行记录
        [[NSUserDefaults standardUserDefaults]setObject:@YES forKey:@"isRuned"];
    }
    
    [self.guidePageView.GoInButton addTarget:self action:@selector(goInButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)goInButtonClick
{
    [self.guidePageView removeFromSuperview];
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "yy.LoveLife" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LoveLife" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LoveLife.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
