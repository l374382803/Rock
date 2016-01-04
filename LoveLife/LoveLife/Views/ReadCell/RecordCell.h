//
//  RecordCell.h
//  LoveLife
//
//  Created by 杨阳 on 16/1/3.
//  Copyright © 2016年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"

@interface RecordCell : UITableViewCell
{
    //头像
    UIImageView * _headImageView;
    //昵称
    UILabel * _nickNameLabel;
    //时间
    UILabel * _timeLabel;
    UIImageView * _mainImageView;
    UILabel * _contentLabel;
}

//获取cell的高度
@property(nonatomic,assign) CGFloat cellHeight;

-(void)configUI:(RecordModel *)model;


@end
