//
//  CmTypesXMLParser.h
//  JOne
//
//  Created by Johnny on 20/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CmTypesXMLParser : NSObject <NSXMLParserDelegate>

@property (strong,nonatomic) NSMutableArray *cmTypes;
@property (strong,nonatomic) NSString *currentTagName;

-(void)start;

@end
