//
//  RootViewController.h
//  LOvelife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
@property(nonatomic,strong) UIButton * leftbutton;
@property(nonatomic,strong) UIButton *rightbutton;
@property(nonatomic,strong)UILabel *titleLable;

//
- (void)setLeftbuttonClick:(SEL)selector;
- (void)setRightbuttonClick:(SEL)selector;
@end
