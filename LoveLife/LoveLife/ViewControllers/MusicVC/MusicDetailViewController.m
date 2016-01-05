//
//  MusicDetailViewController.m
//  LoveLife
//
//  Created by 杨阳 on 16/1/4.
//  Copyright © 2016年 yangyang. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "MBProgressHUD.h"
#import "MusicModel.h"
#import "MisicListCell.h"

@interface MusicDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    //分页
    int _page;
}
//数据源
@property(nonatomic,strong) NSMutableArray * dataArray;
@property(nonatomic,strong) MBProgressHUD * hud;
//MP3
@property(nonatomic,strong) NSMutableArray *urlArray;

@end

@implementation MusicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    //刚进入页面显示的数据
    [self loadData];
    [self settingNav];
    [self createTableView];
    [self createRefresh];
}

#pragma mark - 请求数据
-(void)createRefresh
{
    
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
//上拉加载的数据
-(void)loadMoreData
{
    _page ++;
    [self loadData];
}

-(void)loadData
{
    //让活动指示开始工作
    [self.hud show:YES];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager GET:self.urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary * dic in responseObject[@"data"]) {
            MusicModel * model = [[MusicModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        
        //数据请成功之后，停止刷新，结束活动指示器，刷新界面
        [_tableView.footer endRefreshing];
        [self.hud hide:YES];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 创建tableView
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //创建活动指示器
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    //设置加载文字
    self.hud.labelText = @"正在加载...";
    //设置加载文字的大小
    self.hud.labelFont = [UIFont systemFontOfSize:14];
    //设置加载文字的颜色
    self.hud.labelColor = [UIColor whiteColor];
    //设置背景颜色
    self.hud.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    //设置中间指示器的颜色
    self.hud.activityIndicatorColor = [UIColor whiteColor];
    [self.view addSubview:self.hud];
}

#pragma mark - 实现代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MisicListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MisicListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //赋值
    if (self.dataArray) {
        MusicModel * model = self.dataArray[indexPath.row];
        [cell refreshUI:model];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = self.typeString;
    [self.leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self setLeftButtonClick:@selector(leftButtonCLick)];
}

#pragma mark - 按钮响应事件
-(void)leftButtonCLick
{
    [self.navigationController popViewControllerAnimated:YES];
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
