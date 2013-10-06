//
//  SimpleTableDetailVC.m
//  JOne
//
//  Created by Johnny on 5/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "PropertyListTableDetailVC.h"

@interface PropertyListTableDetailVC ()

@end

@implementation PropertyListTableDetailVC

@synthesize imageView, imageName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    imageView.image = [UIImage imageNamed:imageName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
