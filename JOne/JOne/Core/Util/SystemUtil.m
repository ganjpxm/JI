//
//  JpUtil.m
//  JOne
//
//  Created by Johnny on 2/11/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "SystemUtil.h"

@implementation SystemUtil

+(void) AlertShow:(NSString*)aMsgStr Title:(NSString*)aTitle
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:aTitle
                          message: aMsgStr
                          delegate:Nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil];
    [alert show];
}

+ (float) window_height   {
    return [UIScreen mainScreen].applicationFrame.size.height;
}

+ (float) window_width   {
    return [UIScreen mainScreen].applicationFrame.size.width;
}
@end
