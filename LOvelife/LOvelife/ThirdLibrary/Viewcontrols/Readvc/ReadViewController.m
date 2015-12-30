//
//  ReadViewController.m
//  LOvelife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import "ReadViewController.h"
#import "ArticalViewController.h"
#import "RecordViewController.h"
@interface ReadViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scroll;
    UISegmentedControl *_segment;
}
@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setNav];
    [self creatUI];
}
- (void)setNav
{
    //创建segment
    _segment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    //插入标题
    [_segment insertSegmentWithTitle:@"读美文" atIndex:0 animated:YES];
    [_segment insertSegmentWithTitle:@"看语录" atIndex:1 animated:YES];
    self.navigationItem.titleView = _segment;
    //改变字体的颜色
    _segment.tintColor = [UIColor whiteColor];
    //设置默认选中第一个
    _segment.selectedSegmentIndex = 0;
    [_segment addTarget:self action:@selector(segmentclick:) forControlEvents:UIControlEventValueChanged];
    
}
#pragma mark--创建UI
- (void)creatUI
{
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_size.width, Screen_size.height-109)];
    //设置分页
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _scroll.bounces = NO;
    _scroll.scrollEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    //设置contensize

    _scroll.contentSize = CGSizeMake(Screen_size.width*2, Screen_size.width-109);
    
    //实例化子控制器
    ArticalViewController *arc = [[ArticalViewController alloc]init];
    RecordViewController *rec = [[RecordViewController alloc]init];
    NSArray *arr = @[arc,rec];
    //实现滚动式的框架
    int i  = 0;
    for (UIViewController *view in arr) {
        view.view.frame = CGRectMake(i*Screen_size.width, 0, Screen_size.width, Screen_size.height);
        [self addChildViewController:view];
        [_scroll addSubview:view.view];
        i++;
    }
    [self.view addSubview:_scroll];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x < Screen_size.width) {
        _segment.selectedSegmentIndex = 0;
    }else{
        _segment.selectedSegmentIndex = 1;
    }
}
- (void)segmentclick:(UISegmentedControl *)segment
{
        _scroll.contentOffset = CGPointMake(segment.selectedSegmentIndex*Screen_size.width, 0);
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
