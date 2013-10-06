//
//  JpOcBasic.m
//  JOne
//
//  Created by Johnny on 27/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "JpOc.h"
#import "Calculator.h"

#pragma mark -
#pragma mark jpOc(private)
@interface JpOc(private)
- (void)privateMethod;
@end
#pragma mark -
#pragma mark Grammar

@implementation JpOc

NSString *staticStr;

@synthesize publicStr2;

- (id)init
{
    if((self = [super init]))
    {
        if(publicStr1 == nil)
        {
            publicStr1 = [[NSString alloc] init];
            publicStr2 = [[NSString alloc] init];
        }
        if(protectedStr2 == nil)
        {
            protectedStr1 = [[NSString alloc] init];
            protectedStr2 = [[NSString alloc] init];
        }
        if(privateStr == nil)
        {
            privateStr = [[NSString alloc] init];
        }
        if(staticStr == nil)
        {
            staticStr = [[NSString alloc] init];
        }
    }
    return self;
}

+ (void)staticMethod
{
    
}

- (void)publicMethod
{
    
}


+ (void)testOc
{
    JpOc *jpOc = [[JpOc alloc] init];
    [jpOc testBasicType];
    [jpOc testNString];
    [jpOc testCalculator];
}

- (void)testBasicType
{
    int integerVar = 411;
    float floatVar = 3.79;
    double doubleVar = 1.16e+12;
    char charVar = 'N';
    
    //%@ object  %d, %i;  %u; %f;  %x,%X; %o;  %p; %e,%g; %s,%.*s; %c,%C; %lld; %llu; %Lf
    NSLog(@"integer var = %i", integerVar);
    NSLog(@"float var = %f", floatVar);
    NSLog(@"double var = %e", doubleVar);
    NSLog(@"double var = %g", doubleVar);
    NSLog(@"char var = %c", charVar);
    
    int intArray[2][3]={{1,2,3},{4,5,6}};
    int i,j;
    for(i=0;i<2;i++){
        for(j=0;j<3;j++){
            NSLog(@"%i",intArray[i][j]);
        }
        NSLog(@"------");
    }
    NSLog(@"---End---");
}

- (void)testNString
{
    publicStr1 = @"1.Public String 1!";
    publicStr2 = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%d.Public String %i!",2,2]];
    NSLog(@"publicStr1:%@", publicStr1);
    NSLog(@"publicStr2:%@", publicStr2);
    
    BOOL result = [publicStr1 isEqualToString:publicStr2];
    NSLog(@"result:%d",result);
    result = [publicStr1 compare:publicStr2] == NSOrderedSame; //NSOrderedAscending, NSOrderedDescending
    NSLog(@"result:%d",result);

    result = [publicStr1 caseInsensitiveCompare:publicStr2] == NSOrderedSame;
    NSLog(@"Case Insensitive Compare:%d",result);
    
    if (!publicStr1 || [publicStr1 length] == 0) {
        NSLog(@"publicStr1 is null");
    }
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSLog(@"Current Date : %@", currentDateStr);
    NSDate *date =[dateFormat dateFromString:@"1980-01-01 00:00:01"];
    NSLog(@"NSDate : %@", date);
    
}

- (void)testCalculator
{
    Calculator *calc = [Calculator new];
    
    [calc setAccmulator:10.0];
    [calc add:50.];
    [calc divide: 20.0];
    [calc multiply:40];
    [calc subtract:20];
    NSLog(@"The result is %g",[calc accmulator]);
    [calc clear];
    NSLog(@"The accmulator is %g",calc.accmulator);
}

- (void)doIt:(NSString *)actorName movieName:(NSString*)value timesSeen:(int)times
{
    NSLog(@"%@ is my favorite actor in the movie %@, I saw it %i times.",actorName, value, times);
}

// [self performSelector:@selector(testFun)];
-(void)testFun
{
    NSLog(@"testFun");
}

//[self performSelector:@selector(testFun:) withObjects:@"jack"];
//[self performSelector:@selector(testFun:)   withObjects:@"jack" afterDelay:5];
-(void)testFun:(NSString*)name
{
    NSLog(@"name:%@",name);
}

//[self performSelector:@selector(testFun:Addr:)   withObjects:@"jack" withObjects:@"east road"];
-(void)testFun:(NSString*)name Addr:(NSString*)addr
{
    NSLog(@"name:%@ Addr:%@",name,addr);
}

@end
