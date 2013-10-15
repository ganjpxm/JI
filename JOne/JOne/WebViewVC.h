//
//  WebViewVC.h
//  JOne
//
//  Created by Johnny on 5/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"

@interface WebViewVC : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *mWebView;
@property (strong, nonatomic) WebViewJavascriptBridge *javascriptBridge;

- (void)renderButtons:(UIWebView*)webView;
- (void)loadWebPage:(UIWebView*)webView;

@end
