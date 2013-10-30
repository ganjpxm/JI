//
//  DateUtil.h
//  JOne
//
//  Created by Johnny on 29/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

+ (NSInteger) getCurMilliseconded;

+ (NSString *) getDateTimeStrByMilliSecond:(long)aMillisecond;
+ (NSString *) getDateStrByMilliSecond:(long)aMillisecond;

@end
