//
//  JpUtil.m
//  JOne
//
//  Created by Johnny on 26/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "JpData.h"
#import "JpSlideSwitchVC.h"
#import "JpConst.h"
#import <MobileCoreServices/MobileCoreServices.h>

static NSUserDefaults *userDefaults;

@implementation JpData

+ (NSMutableDictionary *)getArticleCategoryAndNCDic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:4];
    NSMutableArray *articleCategories = [[NSMutableArray alloc] initWithArray:[ARTICLES_CATEGORIES componentsSeparatedByString:@","]];
    for (NSString * category in articleCategories) {
        JpSlideSwitchVC *slideSwitchVC = [[JpSlideSwitchVC alloc] init];
        slideSwitchVC.title = category;
        [dic setObject:[[UINavigationController alloc] initWithRootViewController:slideSwitchVC] forKey:category];
    }
    return dic;
}

//Plist
+ (NSMutableDictionary *)getJOneDic
{
    NSString *jonePlistPath = [[NSBundle mainBundle] pathForResource:@"JOne" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:jonePlistPath];
    return dic;
}

//NSUserDefaults
+ (NSString *) getValueUD:(NSString *)aKey
{
    if (!userDefaults) {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return [userDefaults objectForKey:aKey];
}
+ (void) setValueUD:(id)anObject forKey:(NSString *)aKey
{
    if (!userDefaults) {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    [userDefaults setObject:anObject forKey:aKey];
}
@end
