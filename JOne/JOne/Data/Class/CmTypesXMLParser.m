//
//  CmTypesXMLParser.h
//  JOne
//
//  Created by Johnny on 20/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "CmTypesXMLParser.h"

@implementation CmTypesXMLParser


-(void)start
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"CmTypeNSXML" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    _cmTypes = [NSMutableArray new];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%@",parseError);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    _currentTagName = elementName;
    if ([_currentTagName isEqualToString:@"CmType"]) {
        NSString *_id = [attributeDict objectForKey:@"id"];
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:_id forKey:@"id"];
        [_cmTypes addObject:dict];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	string =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""]) {
        return;
    }
    NSMutableDictionary *dict = [_cmTypes lastObject];
    
    if ([_currentTagName isEqualToString:@"strType"] && dict) {
        [dict setObject:string forKey:@"strType"];
	}
    
	if ([_currentTagName isEqualToString:@"dateType"] && dict) {
        [dict setObject:string forKey:@"dateType"];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName;
{
    self.currentTagName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.cmTypes userInfo:nil];
    self.cmTypes = nil;
}

@end
