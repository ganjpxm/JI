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

@synthesize textFieldUi,textViewUi;
@synthesize itemName, formInfo;

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
    textFieldUi.text = itemName;
    
    if (self.formInfo) {
        [self.textFieldUi setText:[self.formInfo valueForKey:@"text_field_value"]];
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
    
    if (self.formInfo) {
        // Update existing formInfo
        [self.formInfo setValue:self.textFieldUi.text forKey:@"text_field_value"];
        [self.formInfo setValue:self.textViewUi.text forKey:@"text_view_value"];
    } else {
        // Create a new formInfo
        NSManagedObject *newFormInfo = [NSEntityDescription insertNewObjectForEntityForName:@"FormInfo" inManagedObjectContext:context];
        [newFormInfo setValue:self.textFieldUi.text forKey:@"text_field_value"];
        [newFormInfo setValue:self.textViewUi.text forKey:@"text_view_value"];
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
