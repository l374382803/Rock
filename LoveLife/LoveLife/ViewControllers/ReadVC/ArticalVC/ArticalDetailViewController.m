//
//  ArticalDetailViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/30.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "ArticalDetailViewController.h"

@interface ArticalDetailViewController ()

@end

@implementation ArticalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self createUI];
}

#pragma mark - 创建UI
-(void)createUI
{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    //loadHTMLString加载的类似标签式的字符串，loadRequest加载的是网址
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL,self.readModel.dataID]]]];
    //使得webView适应屏幕大小
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    //webView与javaSript的交互
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"详情";
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_pressed"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"iconfont-fenxiang"] forState:UIControlStateNormal];
    
    [self setLeftButtonClick:@selector(leftButtonClick)];
    [self setRightButtonClick:@selector(rightButtonClick)];
}

#pragma mark - 按钮响应函数
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//分享
-(void)rightButtonClick
{
    //下载网络图片
    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.readModel.pic]]];
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:APPKEY shareText:[NSString stringWithFormat:ARTICALDETAILURL,self.readModel.dataID] shareImage:image shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline] delegate:nil];
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
