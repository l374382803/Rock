//
//  GuidePages.m
//  LOvelife
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 Aurora. All rights reserved.
//

#import "GuidePages.h"



@implementation GuidePages
{
    UIScrollView *scroller;
}
- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]) {
        //创建scroller
        scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_size.width, Screen_size.height)];
        scroller.bounces = NO;
        scroller.showsHorizontalScrollIndicator = NO;
        scroller.showsVerticalScrollIndicator = NO;
        scroller.pagingEnabled = YES;
        
        scroller.contentSize = CGSizeMake(imageArray.count*Screen_size.width, Screen_size.height);
        [self addSubview:scroller];
        //创建imageview
        for (int i = 0; i < imageArray.count; i++) {
            UIImageView *imageview = [FactoryUI createImageViewWithFrame:CGRectMake(i *Screen_size.width, 0, Screen_size.width, Screen_size.height+64) imageName:imageArray[i]];
            imageview.userInteractionEnabled = YES;
            [scroller addSubview:imageview];
            if (i == imageArray.count - 1) {
                self.enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
                self.enterButton.frame = CGRectMake(200, 200, 100, 100);
                [self.enterButton setImage:[UIImage imageNamed:@"LinkedIn"] forState:UIControlStateNormal];
                [imageview addSubview:self.enterButton];
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
