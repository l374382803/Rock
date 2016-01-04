//
//  MusicViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/29.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicCollectionViewCell.h"
#import "MusicCollectionReusableView.h"
#import "MusicDetailViewController.h"

@interface MusicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView * _collectionView;
}

@property(nonatomic,strong) NSArray * nameArray;
@property(nonatomic,strong) NSArray * urlArray;
@property(nonatomic,strong) NSArray * imageArray;


@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initArray];
    [self settingNav];
    [self createUI];
}

#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"音乐";
}

#pragma mark - 初始化数组
-(void)initArray
{
    self.nameArray = @[@"流行",@"新歌",@"华语",@"英语",@"日语",@"轻音乐",@"民谣",@"韩语",@"歌曲排行榜"];
    self.urlArray = @[liuxing,xinge,huayu,yingyu,riyu,qingyinyue,minyao,hanyu,paihangbang];
    self.imageArray = @[@"shili0",@"shili1",@"shili2",@"shili8",@"shili10",@"shili19",@"shili15",@"shili13",@"shili24"];
}

#pragma mark - 创建UI
-(void)createUI
{
    //创建网格布局对象
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //创建网格对象
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) collectionViewLayout:flowLayout];
    //设置背景色，系统默认的是黑色的
    _collectionView.backgroundColor = [UIColor whiteColor];
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    //注册cell类
    [_collectionView registerClass:[MusicCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //注册header类
    [_collectionView registerClass:[MusicCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"view"];
    //注册footer类
    [_collectionView registerClass:[MusicCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"view"];
}

#pragma mark - 实现代理方法
//确定section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//确定每个section对应的item的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

//创建cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MusicCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //赋值
    [cell.imageView setImage:[UIImage imageNamed:self.imageArray[indexPath.item]]];
    cell.titleLabel.text =  self.nameArray[indexPath.item];
    return cell;
}

//设置item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_W - 20) / 2, 150);
}

//设置垂直间距,默认的垂直和水平间距都是10
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//四周的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//设置header的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(60, 30);
}

//设置footer的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(60, 30);
}

//设置header和footer的view
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MusicCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"view" forIndexPath:indexPath];
    //分别给header和footer赋值
    if (kind == UICollectionElementKindSectionHeader) {
        view.titleLabel.text = @"段头";
    }
    else
    {
        view.titleLabel.text = @"段尾";
    }
    return view;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MusicDetailViewController * vc = [[MusicDetailViewController alloc]init];
    //传值
    vc.typeString = self.nameArray[indexPath.item];
    vc.urlString = self.urlArray[indexPath.item];
    
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
