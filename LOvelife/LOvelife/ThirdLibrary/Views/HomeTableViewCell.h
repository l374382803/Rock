//
//  HomeTableViewCell.h
//  LOvelife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HomeTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *_imageview;
@property (nonatomic,strong)UILabel *_titlelable;
- (void)refreshModel:(HomeModel *)model;
@end
