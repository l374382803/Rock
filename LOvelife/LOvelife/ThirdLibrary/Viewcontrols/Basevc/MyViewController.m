//
//  MyViewController.m
//  LOvelife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import "MyViewController.h"
#import "FootViewController.h"
#import "MineViewController.h"
#import "MusicViewController.h"
#import "ReadViewController.h"
#import "HomeViewController.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatViewController];
}
- (void)creatViewController
{
    //实例化页面
    //首页
    HomeViewController *home = [[HomeViewController alloc]init];
    //美食
    FootViewController *foot = [[FootViewController alloc]init];
    //音乐
    MusicViewController *music = [[MusicViewController alloc]init];
    //我的
    MineViewController *mine = [[MineViewController alloc]init];
    //读
    ReadViewController *read = [[ReadViewController alloc]init];
    UINavigationController *musicnav = [[UINavigationController alloc]initWithRootViewController:music];
    
     UINavigationController *minenav = [[UINavigationController alloc]initWithRootViewController:mine];
     UINavigationController *footnav = [[UINavigationController alloc]initWithRootViewController:foot];
     UINavigationController *homenav = [[UINavigationController alloc]initWithRootViewController:home];
     UINavigationController *readnav = [[UINavigationController alloc]initWithRootViewController:read];
    NSArray *arr = @[homenav,footnav,readnav,musicnav,minenav];
    
    //未选中
    NSArray *unSelectedArray = @[@"ic_tab_home_normal@2x",@"ic_tab_home_normal@2x",@"ic_tab_home_normal@2x",@"ic_tab_home_normal@2x",@"ic_tab_home_normal@2x"];
    //选中
    NSArray *selectedImageArray = @[@"ic_tab_home_selected@2x",@"ic_tab_home_selected@2x",@"ic_tab_home_selected@2x",@"ic_tab_home_selected@2x",@"ic_tab_home_selected@2x"];
    //标题
    NSArray *titleArray = @[@"首页",@"音乐",@"音乐",@"音乐",@"音乐"];
    for (int i = 0; i < titleArray.count; i++) {
        UIImage *unimage = [UIImage imageNamed:unSelectedArray[i]];
        unimage = [unimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedimage = [UIImage imageNamed:selectedImageArray[i]];
        selectedimage = [selectedimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //获取items并赋值
        //UITabBarItem *item = self.tabBar.items[i];
        //NSLog(@"----%ld",self.tabBar.items.count);
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:titleArray[i] image:unimage selectedImage:selectedimage];
        UINavigationController *nav = arr[i];
        self.tabBar.tintColor = [UIColor redColor];
        nav.tabBarItem = item;
    }

    self.viewControllers = @[homenav,footnav,readnav,musicnav,minenav];
    //[self creatTabbarItem];
}
- (void)creatTabbarItem
{
    //未选中
    NSArray *unSelectedArray = @[@"ic_tab_home_normal@2x",@"ic_tab_home_normal@2x",@"ic_tab_home_normal@2x",@"ic_tab_home_normal@2x",@"ic_tab_home_normal@2x"];
    //选中
    NSArray *selectedImageArray = @[@"ic_tab_home_selected@2x",@"ic_tab_home_selected@2x",@"ic_tab_home_selected@2x",@"ic_tab_home_selected@2x",@"ic_tab_home_selected@2x"];
    //标题
    NSArray *titleArray = @[@"首页",@"音乐",@"读书",@"美食",@"我的"];
    for (int i = 0; i < titleArray.count; i++) {
        UIImage *unimage = [UIImage imageNamed:unSelectedArray[i]];
        unimage = [unimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedimage = [UIImage imageNamed:selectedImageArray[i]];
        selectedimage = [selectedimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //获取items并赋值
        UITabBarItem *item = self.tabBar.items[i];
        NSLog(@"----%ld",self.tabBar.items.count);
        item = [[UITabBarItem alloc]initWithTitle:titleArray[i] image:unimage selectedImage:selectedimage];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
