//
//  RecordModel.m
//  LoveLife
//
//  Created by 杨阳 on 16/1/3.
//  Copyright © 2016年 yangyang. All rights reserved.
//

#import "RecordModel.h"

@implementation RecordModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.dataID = value;
    }
}


@end
