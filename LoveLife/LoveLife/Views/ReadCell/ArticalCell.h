//
//  ArticalCell.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/30.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadModel.h"
@interface ArticalCell : UITableViewCell
{
    //图片
    UIImageView * _imageView;
    //时间
    UILabel * _timeLabel;
    //作者
    UILabel * _authorLabel;
    //标题
    UILabel * _titleLabel;
}

-(void)refreshUI:(ReadModel *)model;

@end
