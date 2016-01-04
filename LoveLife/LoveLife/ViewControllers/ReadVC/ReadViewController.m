//
//  ReadViewController.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/29.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "ReadViewController.h"
#import "ArticalViewController.h"
#import "RecordViewController.h"

@interface ReadViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    UISegmentedControl * _segmentControl;
}

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setingNav];
    [self createUI];
}

-(void)setingNav
{
    //创建segment
    _segmentControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 100, 25)];
    //插入标题
    [_segmentControl insertSegmentWithTitle:@"读美文" atIndex:0 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"看语录" atIndex:1 animated:YES];
    //设置字体颜色
    _segmentControl.tintColor = [UIColor whiteColor];
    //_segmentControl.backgroundColor = [UIColor whiteColor];
    //设置默认选中读美文
    _segmentControl.selectedSegmentIndex = 0;
    //响应方法
    [_segmentControl addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentControl;
}

#pragma 创建UI
-(void)createUI
{
    //创建scrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    //设置代理
    _scrollView.delegate = self;
    //设置分页
    _scrollView.pagingEnabled = YES;
    //关闭滑动效果
    //_scrollView.scrollEnabled = NO;
    //隐藏指示条
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    //设置contentSize
    _scrollView.contentSize = CGSizeMake(SCREEN_W  * 2,0);
    
    //实例化子控制器
    ArticalViewController * articalVC = [[ArticalViewController alloc]init];
    RecordViewController * recordVC = [[RecordViewController alloc]init];
    recordVC.view.backgroundColor = [UIColor redColor];
    NSArray * VCArray = @[articalVC,recordVC];
    
    //滚动式的框架实现
    int i = 0;
    for (UIViewController * vc in VCArray) {
        vc.view.frame = CGRectMake(i * SCREEN_W, 0, SCREEN_W, SCREEN_H);
        [self addChildViewController:vc];
        [_scrollView addSubview:vc.view];
        i ++;
    }
    
}

#pragma mark - segment响应方法
//segment改变的时候关联scrollView
-(void)changeOption:(UISegmentedControl *)segment
{
    _scrollView.contentOffset = CGPointMake(segment.selectedSegmentIndex * SCREEN_W, 0);
}
//scrollView滑动的时候关联segment
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _segmentControl.selectedSegmentIndex = scrollView.contentOffset.x / SCREEN_W;
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
