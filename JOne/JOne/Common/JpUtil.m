//
//  JpUtil.m
//  JOne
//
//  Created by Johnny on 26/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "JpUtil.h"
#import "JpSlideSwitchVC.h"
#import "JpConst.h"

@implementation JpUtil

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

@end
