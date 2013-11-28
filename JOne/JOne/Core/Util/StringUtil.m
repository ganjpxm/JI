//
//  StringUtil.m
//  JOne
//
//  Created by Johnny on 30/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil

+ (NSString *) convertStr:(id) anObject
{
    return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",anObject]];
}

+ (NSString*)textToHtml:(NSString*)htmlString {
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&"  withString:@"&amp;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<"  withString:@"&lt;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@">"  withString:@"&gt;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"""" withString:@"&quot;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"'"  withString:@"&#039;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    return htmlString;
}
@end
