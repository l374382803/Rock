//
//  LeftViewController.m
//  LOvelife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import "LeftViewController.h"
#import "UIImage+MJ.h"
#import "MCAvatarView.h"
@interface LeftViewController ()
{
    MCAvatarView *mcview;
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    //UIImageView *iamgeview = [[UIImageView alloc]initWithImage:[UIImage circleImageWithName:@"welcome3" borderWidth:5.0 borderColor:[UIColor blackColor]]];
    
    //[self.view addSubview:iamgeview];
    mcview = [[MCAvatarView alloc]initWithFrame:CGRectMake(20, 50, 100, 100)];
    mcview.borderColor = [UIColor blueColor];
    mcview.borderWidth = 2;
    mcview.tintColor = [UIColor grayColor];
    mcview.image = [UIImage imageNamed:@"fpo_avatar@2x"];
    [self.view addSubview:mcview];
    
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
