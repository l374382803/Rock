//
//  AppDelegate.m
//  LOvelife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import "AppDelegate.h"
#import "MyViewController.h"
#import "GuidePages.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"

#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
@interface AppDelegate ()
{
    MyViewController *myview;
    GuidePages *viewpage;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
     myview = [[MyViewController alloc]init];
    
    LeftViewController *left = [[LeftViewController alloc]init];
    
    MMDrawerController *draw = [[MMDrawerController alloc]initWithCenterViewController:(UIViewController *)myview leftDrawerViewController:left];
    //设置打开或关闭的方式
    draw.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    draw.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    //设置左页面的宽度
    draw.maximumLeftDrawerWidth = Screen_size.width-150;
    self.window.rootViewController = draw;
   
    
    //修改状态栏的颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //添加引导页
    [self creatGuidPage];
    //添加U盟分享
    [self addUmengShare];
    return YES;
}
- (void)addUmengShare
{
    //注册U盟分享
    [UMSocialData setAppKey:APPKEY];
    //打开QQ appid appsecret
    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@"MnGtpPN5AiB6MNvj" url:nil];
    //打开微博sso开关
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    //打开微信appid appsecret
    [UMSocialWechatHandler setWXAppId:@"wx12b249bcbf753e87" appSecret:@"0a9cd00c48ee47a9b23119086bcd3b30" url:nil];
    //隐藏未安装的客户端
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    
}

- (void)creatGuidPage
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isRun"]boolValue]) {
        //第一次运行完后进行记录
        
        NSArray *arr = @[@"LaunchImage",@"LaunchImage",@"LaunchImage",@"LaunchImage"];
        viewpage = [[GuidePages alloc]initWithFrame:self.window.bounds imageArray:arr];
        [myview.view addSubview:viewpage];
        [[NSUserDefaults standardUserDefaults]setObject:@NO forKey:@"isRun"];
        [viewpage.enterButton addTarget:self action:@selector(enterButtonclick)  forControlEvents:UIControlEventTouchUpInside];
    }
  
    
}
- (void)enterButtonclick
{
    [viewpage removeFromSuperview];
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
