//
//  FoodCollectionViewCell.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/31.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "FoodCollectionViewCell.h"

@interface FoodCollectionViewCell ()
@property(nonatomic,strong) FoodModel * foodModel;

@end

@implementation FoodCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
}

-(void)createUI
{
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, (SCREEN_W - 20) / 2 - 20, 130) imageName:nil];
    _imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_imageView];
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.size.height + _imageView.frame.origin.y + 5, _imageView.frame.size.width, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:15]];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    
    _desLabel = [FactoryUI createLabelWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.size.height + _titleLabel.frame.origin.y , _titleLabel.frame.size.width, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12]];
    [self.contentView addSubview:_desLabel];
    
    UIButton * playButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 40, 40) title:nil titleColor:nil imageName:@"iconfont-bofang-3" backgroundImageName:nil target:self selector:@selector(playButtonClick)];
    playButton.center = _imageView.center;
    [_imageView addSubview:playButton];
}

-(void)refreshUI:(FoodModel *)model
{
    _foodModel = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = model.title;
    _desLabel.text = model.detail;
    
}
//播放按钮
-(void)playButtonClick
{
    if ([_delegate respondsToSelector:@selector(play:)]) {
        [_delegate play:_foodModel];
    }
}

@end
