//
//  ArticalViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/30.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "ArticalViewController.h"
#import "ReadModel.h"
#import "ArticalCell.h"
#import "ArticalDetailViewController.h"

@interface ArticalViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    //分页
    int _page;
}

@property(nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation ArticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self createRefresh];
}

#pragma mark - 请求数据
-(void)createRefresh
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableView.header beginRefreshing];
}
//下拉刷新
-(void)loadNewData
{
    _page = 0;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self getData];
}
//上拉加载
-(void)loadMoreData
{
    _page ++;
    [self getData];
}

-(void)getData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //手动设置格式，默认支持json
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [manager GET:[NSString stringWithFormat:ARTICALURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray * array = responseObject[@"data"];
        for (NSDictionary * dic in array) {
            ReadModel * model = [[ReadModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        if (_page == 0) {
            [_tableView.header endRefreshing];
        }
        else
        {
            [_tableView.footer endRefreshing];
        }
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 创建tableVIew
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticalCell * cell = [tableView dequeueReusableCellWithIdentifier:@"articalCell"];
    if (!cell) {
        cell = [[ArticalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"articalCell"];
    }
    
    if (self.dataArray) {
        ReadModel * model = self.dataArray[indexPath.row];
        [cell refreshUI:model];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
//给cell添加一个动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cell的动画效果为3D效果
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticalDetailViewController * vc = [[ArticalDetailViewController alloc]init];
    ReadModel * model = self.dataArray[indexPath.row];
    vc.readModel = model;
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
