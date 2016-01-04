//
//  HomeCell.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/29.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI
{
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 10, SCREEN_W - 20, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:18]];
    [self.contentView addSubview:_titleLabel];
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, _titleLabel.frame.size.height + _titleLabel.frame.origin.y + 10, SCREEN_W - 20, 150) imageName:nil];
    [self.contentView addSubview:_imageView];
}

-(void)refreshUI:(HomeModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = model.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
