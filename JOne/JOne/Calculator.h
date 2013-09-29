//
//  Calculator.h
//  JOne
//
//  Created by Johnny on 29/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

-(void) setAccmulator:(double) val;
-(void) clear;
-(double) accmulator;

-(void) add:(double) val;
-(void) subtract:(double) val;
-(void) multiply:(double) val;
-(void) divide:(double)val;

@end
