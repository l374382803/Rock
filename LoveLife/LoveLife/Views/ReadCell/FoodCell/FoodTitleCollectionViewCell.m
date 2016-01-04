//
//  FoodTitleCollectionViewCell.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/31.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "FoodTitleCollectionViewCell.h"

@implementation FoodTitleCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.tilteLabel =  [FactoryUI createLabelWithFrame:CGRectMake(0, 0, (SCREEN_W - 20) / 2, 30) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
        self.tilteLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.tilteLabel];
    }
    
    return self;
}

@end
