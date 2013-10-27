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

@synthesize textFieldUi,textViewUi,datePickerUi;
@synthesize itemName, cmType;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

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
    [self.scrollViewUi setScrollEnabled:YES];
    [self.scrollViewUi setContentSize:CGSizeMake(320, 1000)];
    
    textFieldUi.text = itemName;
    
    if (self.cmType) {
        [self.textFieldUi setText:[self.cmType valueForKey:@"strType"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onCancel:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onSave:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.cmType) {
        // Update existing CmType
        [self.cmType setValue:self.textFieldUi.text forKey:@"strType"];
        [self.cmType setValue:self.datePickerUi.date forKey:@"dateType"];
    } else {
        // Create a new CmType
        NSManagedObject *newCmType = [NSEntityDescription insertNewObjectForEntityForName:@"CmType" inManagedObjectContext:context];
        [newCmType setValue:self.textFieldUi.text forKey:@"strType"];
        [newCmType setValue:self.datePickerUi.date forKey:@"dateType"];
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    if (textField == self.textFieldUi) {
        [textField resignFirstResponder];
    }
    return YES;
}

-(BOOL) textViewShouldReturn: (UITextView *) textView {
    [textView resignFirstResponder];
    return YES;
}

@end
