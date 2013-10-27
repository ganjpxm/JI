//
//  CollectionDetailVC.m
//  JOne
//
//  Created by Johnny on 6/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "CollectionDetailVC.h"

@interface CollectionDetailVC ()

@end

@implementation CollectionDetailVC

@synthesize imageName,imageUi;

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
    self.imageUi.image = [UIImage imageNamed:self.imageName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
