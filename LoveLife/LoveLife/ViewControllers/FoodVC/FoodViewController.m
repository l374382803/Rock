//
//  FoodViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/29.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "FoodViewController.h"
#import "NBWaterFlowLayout.h"
#import "FoodTitleCollectionViewCell.h"
#import "FoodCollectionViewCell.h"
#import "FoodModel.h"
#import "PlayViewController.h"
#import "FoodDetailViewController.h"

//视频播放
#import <MediaPlayer/MediaPlayer.h>
//iOS9下的视频播放
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>




@interface FoodViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterFlowLayout,playDelegate>
{
    UICollectionView * _collectionView;
    //分类id
    NSString * _categoryId;
    //标题
    NSString * _titleString;
    //指示条
    UIView * _lineView;
    //分页
    int _page;
}

@property(nonatomic,strong) NSMutableArray * dataArray;
//button数组
@property(nonatomic,strong) NSMutableArray * buttonArray;
@end

@implementation FoodViewController

-(void)viewWillAppear:(BOOL)animated
{
    for (UIButton * btn in self.buttonArray) {
        if (btn == [self.buttonArray firstObject]) {
            btn.selected = YES;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self settingNav];
    [self createHeaderView];
    [self createColloectionView];
    [self createRefresh];
    
}

#pragma mark - 创建刷新请求数据
-(void)createRefresh
{
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _collectionView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [_collectionView.header beginRefreshing];
}

-(void)loadNewData
{
    _page = 0;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self getData];
}

-(void)loadMoreData
{
    _page ++;
    [self getData];
}

//请求数据
-(void)getData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSDictionary * dic = @{@"methodName": @"HomeSerial", @"page": [NSString stringWithFormat:@"%d",_page], @"serial_id": _categoryId, @"size": @"20"};
    [manager POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"code"]intValue] == 0)
        {
            for (NSDictionary * dic in responseObject[@"data"][@"data"])
            {
                //字典转模型
                FoodModel * model = [[FoodModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
        }
        
        if (_page == 0) {
            [_collectionView.header endRefreshing];
        }
        else
        {
            [_collectionView.footer endRefreshing];
        }
        
        [_collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 创建collectionView
-(void)createColloectionView
{
    //创建网格布局对象
    NBWaterFlowLayout * flowLayout = [[NBWaterFlowLayout alloc]init];
    //网格的大小
    flowLayout.itemSize = CGSizeMake((SCREEN_W - 20) / 2, 150);
    //设置列数
    flowLayout.numberOfColumns = 2;
    //设置代理
    flowLayout.delegate = self;
    
    //创建网格对象
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_W, SCREEN_H - 40) collectionViewLayout:flowLayout];
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //设置背景色，默认是黑色的
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    //注册cell
    [_collectionView registerClass:[FoodTitleCollectionViewCell class] forCellWithReuseIdentifier:@"foodTitle"];
    [_collectionView registerClass:[FoodCollectionViewCell class] forCellWithReuseIdentifier:@"food"];
}

#pragma mark - 实现collectionView的代理方法
//确定个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.dataArray ? self.dataArray.count + 1 : 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //标题
        FoodTitleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"foodTitle" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        //赋值
        cell.tilteLabel.text = _titleString;
        return cell;
    }
    else
    {
        //正文
        FoodCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"food" forIndexPath:indexPath];
        //设置代理
        cell.delegate = self;
        //赋值
        if (self.dataArray) {
            FoodModel * model = self.dataArray[indexPath.row - 1];
            [cell refreshUI:model];
        }
        return cell;
    }
}

//设置cell的高度
-(CGFloat)collectionView:(UICollectionView *)collectionView waterFlowLayout:(NBWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 30;
    }
    else
    {
        return 170;
    }
    
}

//点击传值
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailViewController * detailVC =[[FoodDetailViewController alloc]init];
    
    //传值
    FoodModel * model = self.dataArray[indexPath.row];
    detailVC.dataId = model.dishes_id;
    detailVC.NavTitle = model.title;
    detailVC.videoUrl = model.video;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}



#pragma mark - 实现自定义的代理方法
-(void)play:(FoodModel *)model
{
    //进行视频播放
    //默认播放
//    MPMoviePlayerViewController * playerVC = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:model.video]];
//    //强制横屏播放
//    //PlayViewController * playerVC = [[PlayViewController alloc]initWithContentURL:[NSURL URLWithString:model.video]];
//    //准备播放
//    [playerVC.moviePlayer prepareToPlay];
//    //开始播放
//    [playerVC.moviePlayer play];
//    //页面跳转
//    [self presentViewController:playerVC animated:YES completion:nil];
    
    //初始化播放器
    AVPlayerViewController * playerVC = [[AVPlayerViewController alloc]init];
    //设置播放资源
    AVPlayer * avPlayer = [AVPlayer playerWithURL:[NSURL URLWithString:model.video]];
    playerVC.player= avPlayer;
    [self presentViewController:playerVC animated:YES completion:nil];
    
}

#pragma mark - 数据初始化
-(void)initData
{
    _categoryId = @"1";
    _titleString = @"家常菜";
    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"美食";
}

#pragma mark - 创建头部分类按钮
-(void)createHeaderView
{
    NSArray * titleArray = @[@"家常菜",@"小炒",@"凉菜",@"烘培"];
    UIView * bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton * headerButton = [FactoryUI createButtonWithFrame:CGRectMake(i * SCREEN_W / 4, 0, SCREEN_W / 4, 40) title:titleArray[i] titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(headerButtonClick:)];
        //设置选中时候的颜色
        [headerButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        headerButton.titleLabel.font = [UIFont systemFontOfSize:15];
        headerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        headerButton.tag = 10 + i;
        [bgView addSubview:headerButton];
        //将创建的button添加到数组中
        [self.buttonArray addObject:headerButton];
    }
    //滑动指示条
    _lineView = [FactoryUI createViewWithFrame:CGRectMake(0, 38, SCREEN_W / 4, 2)];
    _lineView.backgroundColor = [UIColor redColor];
    [bgView addSubview:_lineView];
}

#pragma mark - 按钮响应方法
-(void)headerButtonClick:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake((button.tag - 10) * SCREEN_W / 4, 38, SCREEN_W / 4, 2);
    }];
    
    //保证让每次点击的时候只选中一个按钮
    for (UIButton * btn in self.buttonArray) {
        if (btn.selected == YES) {
            btn.selected = NO;
        }
    }
    button.selected = YES;
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
