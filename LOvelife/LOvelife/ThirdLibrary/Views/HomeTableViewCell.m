//
//  HomeTableViewCell.m
//  LOvelife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI
{
    __titlelable = [FactoryUI createLabelWithFrame:CGRectMake(10, 10, Screen_size.width-20, 20) text:nil textColor:[UIColor redColor] font:[UIFont systemFontOfSize:18]];
    [self.contentView addSubview:__titlelable];
    __imageview = [FactoryUI createImageViewWithFrame:CGRectMake(10, CGRectGetMaxY(__titlelable.frame)+5, Screen_size.width-20, 100) imageName:nil];
    [self.contentView addSubview:__imageview];
}
- (void)refreshModel:(HomeModel *)model
{
    [__imageview sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:nil];
    __titlelable.text = model.title;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
