//
//  RootViewController.m
//  LOvelife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatRootNav];
}
- (void)creatRootNav
{
    //设置导航不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航的颜色
    self.navigationController.navigationBar.barTintColor = UIcolor(255, 117, 35);
    
    //(1)修改状态栏的颜色
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //左按钮
    self.leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftbutton.frame = CGRectMake(0, 0, 44, 44);
    [self.leftbutton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftbutton];
    
    //设置标题
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 25)];
    self.titleLable.textColor = UIcolor(150, 20, 40);
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = self.titleLable;
    //右按钮
    self.rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftbutton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.rightbutton.frame = CGRectMake(0, 0, 44, 44);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightbutton];
    
}
- (void)setLeftbuttonClick:(SEL)selector
{
    [self.leftbutton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}
- (void)setRightbuttonClick:(SEL)selector
{
    [self.rightbutton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
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
