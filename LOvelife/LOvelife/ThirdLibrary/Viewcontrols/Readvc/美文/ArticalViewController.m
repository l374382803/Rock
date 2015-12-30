//
//  ArticalViewController.m
//  LOvelife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import "ArticalViewController.h"
#import "ReadModel.h"
#import "ReadTableViewCell.h"
#import "ArticalDetailViewController.h"
@interface ArticalViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *dataArray;
    int page;
}
@end

@implementation ArticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self creatUI];
    [self creatRefresh];
}
- (void)creatRefresh
{
    _tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _tableview.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableview.header beginRefreshing];
}
- (void)loadData
{
    page = 1;
    dataArray = [NSMutableArray arrayWithCapacity:0];
    [self getData];
    
}
- (void)loadMoreData
{
    page++;
    [self getData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
- (void)getData
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //手动设置数据格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    [manager GET:[NSString stringWithFormat:ARTICALURL,page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"------%@",responseObject);
        NSArray *arr = responseObject[@"data"];
        for (NSDictionary *dic in arr) {
            ReadModel *read = [[ReadModel alloc]init];
            [read setValuesForKeysWithDictionary:dic];
            [dataArray addObject:read];
        }
        [_tableview reloadData];
        if (page == 1) {
            [_tableview.header endRefreshing];
        }else{
            [_tableview.footer endRefreshing];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)creatUI
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_size.width, Screen_size.height-109) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ReadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    ReadModel *model = dataArray[indexPath.row];
    [cell resfreshData:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cell的动画效果为3D效果
    cell.layer.transform = CATransform3DMakeScale(0, 0.1, 1);
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticalDetailViewController *arti = [[ArticalDetailViewController alloc]init];
    ReadModel *model = dataArray[indexPath.row];
    arti.readModel = model;
    [self.navigationController pushViewController:arti animated:YES];
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
