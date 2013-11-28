//
//  JqueryMobileVC.m
//  JOne
//
//  Created by Johnny on 15/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "JqueryMobileVC.h"

@interface JqueryMobileVC ()

@end

@implementation JqueryMobileVC
@synthesize mWebView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setHidden:YES];
    
    mWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320,568)];
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"cashline/index.html" ofType:nil]];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:url];
    [mWebView loadRequest:nsrequest];
    [self.view addSubview:mWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
