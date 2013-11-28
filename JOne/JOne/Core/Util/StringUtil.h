//
//  StringUtil.h
//  JOne
//
//  Created by Johnny on 30/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

+ (NSString *) convertStr:(id) anObject;

+ (NSString*)textToHtml:(NSString*)htmlString;
@end
