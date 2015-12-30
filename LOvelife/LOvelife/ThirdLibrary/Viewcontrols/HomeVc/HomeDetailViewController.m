//
//  HomeDetailViewController.m
//  LOvelife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    //
    UIImageView *_imageview;
    //头部文字
    UILabel *_headerTitle;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableDictionary *dataDic;

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self creatUI];
    [self loadData];
}
#pragma mark--设置导航
- (void)setNav
{
    self.titleLable.text = @"详情";
    [self.leftbutton setImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [self setLeftbuttonClick:@selector(leftButtonClick)];
    [self.rightbutton setImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [self setRightbuttonClick:@selector(rightButtonclick)];
}
- (void)leftButtonClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)rightButtonclick
{
    
}
- (void)loadData
{
    //初始化
    self.dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:HOMEDETAIL,[self.detailUrl intValue]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //头部视图的数据
        self.dataDic = responseObject[@"data"];
        //tableview的数据
        self.dataArray = self.dataDic[@"product"];
        //数据请求后刷新页面
        [self reloadHeaderView];
        [_tableview reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)reloadHeaderView
{
    [_imageview sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"pic"]]];
    _headerTitle.text = self.dataDic[@"title"];
}
- (void)creatUI
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_size.width, Screen_size.height-64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    _imageview = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, Screen_size.width, Screen_size.height/3) imageName:@""];
    _headerTitle = [FactoryUI createLabelWithFrame:CGRectMake(0, _imageview.frame.size.height - 40, Screen_size.width, 40) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18]];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = self.dataArray[section][@"pic"];
    return sectionArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UIImageView *imageview = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, Screen_size.width-20, 200) imageName:nil];
        imageview.tag = 10;
        [cell.contentView addSubview:imageview];
    }
    //赋值
    UIImageView *ima = (UIImageView *)[cell.contentView viewWithTag:10];
    if (self.dataArray) {
        NSArray *sectionArr = self.dataArray[indexPath.section][@"pic"];
        [ima sd_setImageWithURL:[NSURL URLWithString:sectionArr[indexPath.row][@"pic"]]];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"123";
}
//设置每个section的header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, Screen_size.width, 60)];
    backView.backgroundColor = [UIColor whiteColor];
    //索引
    UILabel *indexLable = [FactoryUI createLabelWithFrame:CGRectMake(10, 10, 40, 40) text:[NSString stringWithFormat:@"%ld",section] textColor:[UIColor redColor] font:[UIFont systemFontOfSize:18]];
    indexLable.layer.borderColor = [UIColor greenColor].CGColor;
    indexLable.textAlignment = NSTextAlignmentCenter;
    indexLable.layer.borderWidth = 2;
    [backView addSubview:indexLable];
    //标题
    UILabel *titleLable = [FactoryUI createLabelWithFrame:CGRectMake(indexLable.frame.size.width+indexLable.frame.origin.x+10, 10, Screen_size.width-CGRectGetMaxX(indexLable.frame)-75, 40) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:18]];
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.text = self.dataArray[section][@"title"];
    [backView addSubview:titleLable];
    
    //价钱
    UIButton *priceButton = [FactoryUI createButtonWithFrame:CGRectMake(Screen_size.width-70, 10, 60, 40) title:nil titleColor:nil imageName:nil backgroundImageName:nil target:nil selector:@selector(priceClick)];
    [backView addSubview:priceButton];
    [priceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [priceButton setTitle:[NSString stringWithFormat:@"￥%@",self.dataArray[section][@"price"]] forState:UIControlStateNormal];
    
    return backView;
    
}
- (void)priceClick
{
    
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
