//
//  ArticalDetailViewController.m
//  LOvelife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import "ArticalDetailViewController.h"

@interface ArticalDetailViewController ()
{
    UIWebView *_webview;
}
@end

@implementation ArticalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self creatUI];
}
- (void)creatUI
{
    _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Screen_size.width, Screen_size.height-64)];
    //loadHTMLString加载类似标签式的字符串。loadRequest加载的是网址
    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL,self.readModel.dataID]]]];
    //让webview适应屏幕的大小
    _webview.scalesPageToFit = YES;
    [self.view addSubview:_webview];
    //webview与javascript的交互
}
- (void)setNav
{
    self.titleLable.text = @"详情";
    [self.leftbutton setImage:[UIImage imageNamed:@"iconfont-fenxiang"] forState:UIControlStateNormal];
    [self.rightbutton setImage:[UIImage imageNamed:@"iconfont-fenxiang"] forState:UIControlStateNormal];
    [self setLeftbuttonClick:@selector(leftbuttonclick)];
    [self setRightbuttonClick:@selector(rightbuttonclick)];
}
- (void)leftbuttonclick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)rightbuttonclick
{
    UIImage *ima = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.readModel.pic]]];
    [UMSocialSnsService presentSnsIconSheetView:self appKey:APPKEY shareText:[NSString stringWithFormat:ARTICALDETAILURL,self.readModel.dataID] shareImage:ima shareToSnsNames:@[UMShareToQQ,UMShareToQzone,UMShareToSina,UMShareToWechatSession] delegate:nil];
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
