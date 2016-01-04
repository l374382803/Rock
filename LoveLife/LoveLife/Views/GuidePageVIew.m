//
//  GuidePageVIew.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/29.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "GuidePageVIew.h"

@interface GuidePageVIew ()
{
    UIScrollView * _scrollView;
}

@end

@implementation GuidePageVIew

-(id)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]) {
        //创建scrollView
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H + 64)];
        //设置分页
        _scrollView.pagingEnabled = YES;
        //设置contentSize
        _scrollView.contentSize = CGSizeMake(imageArray.count * SCREEN_W, SCREEN_H + 64);
        [self addSubview:_scrollView];
        
        //创建imageView
        for (int i = 0; i < imageArray.count; i ++)
        {
            UIImageView * imageView = [FactoryUI createImageViewWithFrame:CGRectMake(i * SCREEN_W, 0, SCREEN_W, SCREEN_H + 64) imageName:imageArray[i]];
            //打开用户交互
            imageView.userInteractionEnabled = YES;
            [_scrollView addSubview:imageView];
            
            if (i == imageArray.count - 1) {
                self.GoInButton = [UIButton buttonWithType:UIButtonTypeCustom];
                self.GoInButton.frame = CGRectMake(100, 100, 50, 50);
                [self.GoInButton setImage:[UIImage imageNamed:@"LinkedIn"] forState:UIControlStateNormal];
                [imageView addSubview:self.GoInButton];
            }
        }
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
