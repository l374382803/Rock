//
//  ReadTableViewCell.h
//  LOvelife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReadModel;
@interface ReadTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *imageview;
@property (nonatomic,strong)UILabel *timelable;
@property (nonatomic,strong)UILabel *authorlable;
@property (nonatomic,strong)UILabel *titlelable;
- (void)resfreshData:(ReadModel *)model;
@end
