//
//  JpUtil.h
//  JOne
//
//  Created by Johnny on 2/11/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemUtil : NSObject

+(void) AlertShow:(NSString*)aMsgStr Title:(NSString*)aTitle;

+ (float) window_height;
+ (float) window_width;

@end
