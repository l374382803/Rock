//
//  HomeViewController.m
//  LOvelife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import "HomeViewController.h"
//打开抽屉
#import "UIViewController+MMDrawerController.h"
//二维码扫描
#import "CustomViewController.h"
#import "Carousel.h"
#import "HomeModel.h"
#import "HomeTableViewCell.h"
#import "HomeDetailViewController.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    Carousel *_cycleplaying;
    UITableView *_tableview;
    NSMutableArray *dataArray;
    NSInteger _page;
    
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNav];
    [self creatTableview];
    [self creatTabheaderview];
    [self creatRefresh];
    
    
}
- (void)creatTableview
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_size.width, Screen_size.height) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    //修改分割线
    //方法一
    //_tableview.separatorColor = [UIColor clearColor];
    //方法二
    //_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //去掉多余的线条
    //_tableview.tableFooterView = [[UIView alloc]init];
    
    //剪短分割线的长度
    _tableview.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 10;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    HomeModel *model = dataArray[indexPath.row];
    [cell refreshModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (void)creatTabheaderview
{
    _cycleplaying = [[Carousel alloc]initWithFrame:CGRectMake(0, 0, Screen_size.width, Screen_size.height / 3)];
    //设置是否需要pagecontroller
    _cycleplaying.needPageControl = YES;
    //设置是否需要轮播
    _cycleplaying.infiniteLoop = YES;
    //设置轮播的类型
    _cycleplaying.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_MIDDLE;
    //设置图片的数组
    _cycleplaying.imageArray = @[@"shili8",@"shili2",@"shili0"];
    _tableview.tableHeaderView = _cycleplaying;
    
}
- (void)settingNav
{
    self.titleLable.text = @"爱生活";
    [self.leftbutton setImage:[UIImage imageNamed:@"iconfont-back.png"] forState:UIControlStateNormal];
    [self.rightbutton setImage:[UIImage imageNamed:@"iconfont-back.png"] forState:UIControlStateNormal];
    //设置响应事件
    [self setLeftbuttonClick:@selector(leftbuttonclick)];
    [self setRightbuttonClick:@selector(rightbuttonclick)];
}
- (void)leftbuttonclick
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (void)rightbuttonclick
{
    //设置为no既可以扫描二维码又可以扫描条形码
    CustomViewController *custom = [[CustomViewController alloc]initWithIsQRCode:NO Block:^(NSString * result, BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"%@",@"success");
        }
    }];
    [self.navigationController presentViewController:custom animated:YES completion:nil];
}
- (void)creatRefresh
{
    _tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //当程序启动的时候自动刷新一次
    [_tableview.header beginRefreshing];
}
- (void)loadData
{
    _page = 1;
    if (dataArray == nil) {
        dataArray = [[NSMutableArray alloc]init];
    }else{
        [dataArray removeAllObjects];
    }
    
    [self getData:(_page)];
}
- (void)loadMoreData
{
    
    _page++;
    NSLog(@"加载更多%ld",_page);
    [self getData:(_page)];
}
- (void)getData:(NSInteger)page
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:HOMEURL,page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"data"][@"topic"]) {
           // NSLog(@"%@",dic);
            HomeModel *homemodel = [[HomeModel alloc]init];
            [homemodel setValuesForKeysWithDictionary:dic];
            [dataArray addObject:homemodel];
        }
        
        if (page == 1) {
            [_tableview.header endRefreshing];
        }else{
            [_tableview.footer endRefreshing];
        }
        [_tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailViewController *homedetail = [[HomeDetailViewController alloc]init];
    homedetail.hidesBottomBarWhenPushed = YES;
    HomeModel *model = dataArray[indexPath.row];
    homedetail.detailUrl = model.dataID;
    [self.navigationController pushViewController:homedetail animated:YES];
    
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
