//
//  ReadModel.m
//  LoveLife
//
//  Created by 杨阳 on 15/12/30.
//  Copyright © 2015年 yangyang. All rights reserved.
//

#import "ReadModel.h"

@implementation ReadModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.dataID = value;
    }
}

@end
