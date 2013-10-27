//
//  JpOcBasic.h
//  JOne
//
//  Created by Johnny on 27/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JpOc : NSObject
{
    @public
        NSString *publicStr1;
    @protected
        NSString *protectedStr1;
    @private
        NSString *privateStr;
    
    NSString *protectedStr2;
}

@property (nonatomic, retain) NSString *publicStr2;

+ (void)staticMethod;
- (void)publicMethod;

+ (void)testOc;
- (void)testBasicType;
- (void)testNS;
- (void)testCalculator;

@end
