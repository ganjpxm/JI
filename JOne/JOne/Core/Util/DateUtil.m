//
//  DateUtil.m
//  JOne
//
//  Created by Johnny on 29/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+ (NSInteger) getCurMilliseconded
{
   return ([[NSDate date] timeIntervalSince1970] * 1000);
}


@end
