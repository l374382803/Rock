//
//  HomeCell.h
//  LoveLife
//
//  Created by 杨阳 on 15/12/29.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeCell : UITableViewCell
{
    //图片
    UIImageView * _imageView;
    //标题
    UILabel * _titleLabel;
    
}

-(void)refreshUI:(HomeModel *)model;

@end
