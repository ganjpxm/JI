//
//  Calculator.m
//  JOne
//
//  Created by Johnny on 29/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

{
    double accmulator;
}

-(void) setAccmulator:(double) val
{
    accmulator=val;
}

-(void) clear
{
    accmulator=0;
}

-(double) accmulator
{
    return accmulator;
}

-(void) add:(double) val
{
    accmulator+=val;
}

-(void) subtract:(double) val
{
    accmulator-=val;
}

-(void) multiply:(double) val
{
    accmulator*=val;
}

-(void) divide:(double)val
{
    accmulator/=val;
}


@end
