//
//  FormViewController.m
//  JOne
//
//  Created by Johnny on 27/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "FormVC.h"

@interface FormVC ()

@end

@implementation FormVC

@synthesize nameTf, itemName;

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
    nameTf.text = itemName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
