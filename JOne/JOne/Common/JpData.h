//
//  JpUtil.h
//  JOne
//
//  Created by Johnny on 26/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JpData : NSObject

+ (NSMutableDictionary *)getArticleCategoryAndNCDic;

//Plist
+ (NSMutableDictionary *)getJOneDic;

//NSUserDefaults
+ (NSString *) getValueUD:(NSString *)aKey;
+ (void) setValueUD:(id)anObject forKey:(NSString *)aKey;
@end
