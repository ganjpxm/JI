//
//  NSString+Message.m
//  JOne
//
//  Created by Johnny on 17/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "NSNumber+Message.h"

@implementation NSNumber (Message)

-(NSString *)errorMessage
{
    NSString *errorStr = @"";
    
    switch ([self integerValue]) {
        case -1:
            errorStr = @"No data.";
            break;
        case -2:
            errorStr = @"Access Fail";
            break;
        default:
            break;
    }
    
    return errorStr;
}

@end
