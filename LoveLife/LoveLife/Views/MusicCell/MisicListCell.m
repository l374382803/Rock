//
//  MisicListCell.m
//  LoveLife
//
//  Created by 杨阳 on 16/1/4.
//  Copyright © 2016年 yangyang. All rights reserved.
//

#import "MisicListCell.h"


@implementation MisicListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI
{
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 100, 70) imageName:nil];
    [self.contentView addSubview:_imageView];
    
    _nameLabel = [FactoryUI createLabelWithFrame:CGRectMake(_imageView.frame.size.width + _imageView.frame.origin.x + 10, 20, 150, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_nameLabel];
    
    _authorLabel = [FactoryUI createLabelWithFrame:CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.size.height + _nameLabel.frame.origin.y , 100, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:_authorLabel];
}

-(void)refreshUI:(MusicModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.coverURL] placeholderImage:[UIImage imageNamed:@""]];
    _nameLabel.text = model.title;
    _authorLabel.text = model.artist;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
