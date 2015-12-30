//
//  ReadTableViewCell.m
//  LOvelife
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import "ReadTableViewCell.h"
#import "ReadModel.h"
@implementation ReadTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI
{
    _imageview = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 120, 90) imageName:nil];
    [self.contentView addSubview:_imageview];
    _titlelable = [FactoryUI createLabelWithFrame:CGRectMake(CGRectGetMaxX(_imageview.frame)+10, 10, Screen_size.width-CGRectGetMaxX(_imageview.frame)-20, 100) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:18]];
    _titlelable.numberOfLines = 0;
    _titlelable.textAlignment = NSTextAlignmentLeft;
    _titlelable.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:_titlelable];
    //
    _timelable = [FactoryUI createLabelWithFrame:CGRectMake(10, CGRectGetMaxY(_imageview.frame)+5, 170, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:17]];
    [self.contentView addSubview:_timelable];
    //
    _authorlable = [FactoryUI createLabelWithFrame:CGRectMake(Screen_size.width-150, _timelable.frame.origin.y, 140, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:18]];
    [self.contentView addSubview:_authorlable];
}
- (void)resfreshData:(ReadModel *)model
{
    [_imageview sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    _titlelable.text = model.title;
    _authorlable.text = model.author;
    _timelable.text = model.createtime;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
