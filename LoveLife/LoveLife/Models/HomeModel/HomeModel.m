//
//  HomeModel.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/29.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.dataID = value;
    }
}

@end
