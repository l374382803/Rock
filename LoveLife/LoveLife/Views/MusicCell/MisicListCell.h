//
//  MisicListCell.h
//  LoveLife
//
//  Created by 杨阳 on 16/1/4.
//  Copyright © 2016年 yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface MisicListCell : UITableViewCell
{
    UIImageView * _imageView;
    //演唱者
    UILabel * _authorLabel;
    //歌曲名称
    UILabel * _nameLabel;
    
    
}
-(void)refreshUI:(MusicModel *)model;



@end
