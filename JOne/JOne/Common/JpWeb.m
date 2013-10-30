//
//  JpWeb.m
//  JOne
//
//  Created by Johnny on 29/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "JpWeb.h"
#import "AFNetworking.h"
#import "JpConst.h"
#import "JpData.h"
#import "DateUtil.h"
#import "StringUtil.h"

static NSString *const BaseURLString = @"http://192.168.0.102:8080/jp";//@"http://www.ganjianping.com";

@implementation JpWeb

+ (void) syncJweb
{
    NSString *url = [NSString stringWithFormat:@"%@/login", BaseURLString];
    NSDictionary *parameters = @{@"userCdOrEmail": @"mobile", @"userPassword":@"1"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
              [JpWeb getBmConfigs:YES];
              [JpWeb getCmArticles:YES];
              [JpWeb getCmPhotos:YES];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }
     ];
}

+ (void) getBmConfigs:(BOOL)isUpdate
{
    NSString *url = [NSString stringWithFormat:@"%@/mobile/getBmConfigs", BaseURLString];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    [parameters setObject:@"('AudioUrl','ImageUrl','VideoUrl','FileUrl','MobileTags')" forKey:@"configCds"];
    NSString *lastTime = [JpData getValueUD:KEY_BM_CONFIG_LAST_TIME];
    if (lastTime) {
        if (isUpdate) [parameters setObject:lastTime forKey:KEY_LAST_TIME];
        NSLog(@"BM_CONFIG_LAST_TIME : %@, %@", lastTime, [DateUtil getDateTimeStrByMilliSecond:[lastTime longLongValue]]);
    }
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray *jsonArr = [JpData getJsonArr:responseObject];
              if (jsonArr && [jsonArr count]>0) {
                  NSString *newLastTime = lastTime;
                  for (NSDictionary *dic in jsonArr) {
                      NSString *modifyTime = [dic objectForKey:@"modifyTimestamp"];
                      if (!newLastTime || [modifyTime longLongValue] > [newLastTime longLongValue]) {
                          newLastTime = modifyTime;
                      }
                  }
                  [JpData setValueUD:[StringUtil convertStr:newLastTime] forKey:KEY_BM_CONFIG_LAST_TIME];
                  NSLog(@"BmConfig Count: %lu,%@", [jsonArr count],newLastTime);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }
    ];
}

+ (void) getCmArticles:(BOOL)isUpdate
{
    NSString *url = [NSString stringWithFormat:@"%@/mobile/getCmArticles", BaseURLString];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    NSString *lastTime = [JpData getValueUD:KEY_CM_ARTICLE_LAST_TIME];
    if (lastTime) {
        if (isUpdate) [parameters setObject:[DateUtil getDateTimeStrByMilliSecond:[lastTime longLongValue]] forKey:KEY_START_DATE];
        NSLog(@"CM_ARTICLE_LAST_TIME : %@, %@", lastTime, [DateUtil getDateTimeStrByMilliSecond:[lastTime longLongValue]]);
    }
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray *jsonArr = [JpData getJsonArr:responseObject];
              if (jsonArr && [jsonArr count]>0) {
                  NSString *newLastTime = lastTime;
                  for (NSDictionary *dic in jsonArr) {
                      NSString *modifyTime = [dic objectForKey:@"modifyTimestamp"];
                      if (!newLastTime || [modifyTime longLongValue] > [newLastTime longLongValue]) {
                          newLastTime = modifyTime;
                      }
                  }
                  [JpData setValueUD:[StringUtil convertStr:newLastTime] forKey:KEY_CM_ARTICLE_LAST_TIME];
                  NSLog(@"cmArticle Count: %lu,%@", [jsonArr count], newLastTime);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }
     ];
}

+ (void) getCmPhotos:(BOOL)isUpdate
{
    NSString *url = [NSString stringWithFormat:@"%@/mobile/getCmPhotos", BaseURLString];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    NSString *lastTime = [JpData getValueUD:KEY_CM_PHOTO_LAST_TIME];
    if (lastTime) {
        if (isUpdate) [parameters setObject:[DateUtil getDateTimeStrByMilliSecond:[lastTime longLongValue]] forKey:KEY_START_DATE];
        NSLog(@"CM_PHOTO_LAST_TIME : %@, %@", lastTime, [DateUtil getDateTimeStrByMilliSecond:[lastTime longLongValue]]);
    }
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray *jsonArr = [JpData getJsonArr:responseObject];
              if (jsonArr && [jsonArr count]>0) {
                  NSString *newLastTime = lastTime;
                  for (NSDictionary *dic in jsonArr) {
                      NSString *modifyTime = [dic objectForKey:@"modifyTimestamp"];
                      if (!newLastTime || [modifyTime longLongValue] > [newLastTime longLongValue]) {
                          newLastTime = modifyTime;
                      }
                  }
                  [JpData setValueUD:[StringUtil convertStr:newLastTime] forKey:KEY_CM_PHOTO_LAST_TIME];
                  NSLog(@"cmPhoto Count: %lu,%@", [jsonArr count], newLastTime);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }
     ];
}


//    NSString *weatherUrl = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
//    NSURL *url = [NSURL URLWithString:weatherUrl];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];

//    AFJSONRequestOperation *operation =
//    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
//        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//            self.weather  = (NSDictionary *)JSON;
//            self.title = @"JSON Retrieved";
//            [self.tableView reloadData];
//        }
//        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
//                                                   message:[NSString stringWithFormat:@"%@",error]
//                                                   delegate:nil
//                                                   cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [av show];
//        }
//    ];
//    [operation start];

//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters = @{@"foo": @"bar"};
//    [manager POST:@"http://example.com/resources.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];

//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters = @{@"foo": @"bar"};
//    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
//    [manager POST:@"http://example.com/resources.json" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Success: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
@end
