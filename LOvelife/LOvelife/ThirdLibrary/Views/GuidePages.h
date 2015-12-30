//
//  GuidePages.h
//  LOvelife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuidePages : UIView
@property (nonatomic,strong)UIButton *enterButton;
- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;
@end
