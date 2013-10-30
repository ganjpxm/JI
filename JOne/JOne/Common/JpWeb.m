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

static NSString *const BaseURLString = @"http://www.ganjianping.com";

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
    NSString *lastTime = [JpData getValueUD:KEY_CM_CONFIG_LAST_TIME];
    [JpData setValueUD:@"2323323" forKey:KEY_CM_CONFIG_LAST_TIME];
    if (isUpdate && lastTime) {
        [parameters setObject:lastTime forKey:KEY_LAST_TIME];
    }
    
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//              NSLog(@"JSON: %@", responseObject);
              NSData *responseData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
              NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
              if (jsonArr) {
                  NSString *cmConfigLastTime = [JpData getValueUD:KEY_CM_CONFIG_LAST_TIME];
                  for (NSDictionary *dic in jsonArr) {
                      NSString *time = [dic objectForKey:@"modifyTimestamp"];
                      if (!cmConfigLastTime || [time intValue] > [cmConfigLastTime intValue]) {
                          cmConfigLastTime = time;
                      }
                  }
                  [JpData setValueUD:cmConfigLastTime forKey:KEY_CM_CONFIG_LAST_TIME];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }
    ];
}

+ (void) getCmArticles
{
    NSString *url = [NSString stringWithFormat:@"%@/mobile/getCmArticles", BaseURLString];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = nil; //@{@"startDate": @"0"};
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }
     ];
}

+ (void) getCmPhotos
{
    NSString *url = [NSString stringWithFormat:@"%@/mobile/getCmPhotos", BaseURLString];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = nil; //@{@"startDate": @"0"};
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
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
