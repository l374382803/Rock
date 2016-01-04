//
//  RootViewController.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/29.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
//左按钮
@property(nonatomic,strong) UIButton * leftButton;
//标题
@property(nonatomic,strong) UILabel * titleLabel;
//右按钮
@property(nonatomic,strong) UIButton * rightButton;

//响应事件
-(void)setLeftButtonClick:(SEL)selector;
-(void)setRightButtonClick:(SEL)selector;


@end
