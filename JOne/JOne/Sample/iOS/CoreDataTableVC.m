//
//  TableViewController.m
//  JOne
//
//  Created by Johnny on 6/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "CoreDataTableVC.h"
#import "FormVC.h"
#import "CmTypesXMLParser.h"
#import "NSString+URLEncoding.h"
#import "NSNumber+Message.h"

@interface CoreDataTableVC ()
@property (strong) NSMutableArray *cmTypes;
@end

@implementation CoreDataTableVC

@synthesize tableView;

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
    //NSXML Data
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(reloadView:)
//                                                 name:@"reloadViewNotification"
//                                               object:nil];
//    
//    CmTypesXMLParser *parser = [CmTypesXMLParser new];
//    [parser start];
    
    //NSJSONSerialization Data
    NSString* path = [[NSBundle mainBundle] pathForResource:@"CmTypes" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers error:&error];
    if (!jsonObj || error) {
        NSLog(@"JSON Resolve Fail");
    }
    self.cmTypes = [jsonObj objectForKey:@"Record"];
        
//    [self startRequest];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Core Data : Fetch the devices from persistent data store
//    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CmType"];
//    self.cmTypes = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
//    
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.cmTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSManagedObject *cmType = [self.cmTypes objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [cmType valueForKey:@"strType"]]];
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    [cell.detailTextLabel setText:[dateFormater stringFromDate:[cmType valueForKey:@"dateType"]]];
//    [cell.detailTextLabel setText:[cmType valueForKey:@"dateType"]];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.cmTypes objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.cmTypes removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = self.storyboard;
    FormVC *formVC = [storyboard instantiateViewControllerWithIdentifier:@"FormVC"];
    formVC.cmType = [self.cmTypes objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:formVC  animated:YES];
}

- (IBAction)onAdd:(id)sender {
    UIStoryboard *storyboard = self.storyboard;
    FormVC *formVC = [storyboard instantiateViewControllerWithIdentifier:@"FormVC"];
    [self.navigationController pushViewController:formVC  animated:YES];
}

#pragma mark - do notification
-(void)reloadView:(NSNotification*)notification
{
    NSMutableArray *resList = [notification object];
    self.cmTypes  = resList;
    [self.tableView reloadData];
}

#pragma mark - Network
-(void)startRequest
{
    
    NSString *strURL = [[NSString alloc] initWithFormat:
                        @"http://192.168.0.103:8080/jp/test/json?email=%@&type=%@&action=%@",
                        @"ganjp_xm@sina.com",@"JSON",@"query"];
    
	NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
	
    //cashePolicy, timeoutInterval
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    
    NSData *data  = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    [self reloadViewByJson:resDict];
    
    /*
     NSOperationQueue *queue = [[NSOperationQueue alloc] init];
     [NSURLConnection sendAsynchronousRequest:request
     queue:queue
     completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
     
     NSLog(@"请求完成...");
     NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
     [self reloadView:resDict];
     
     }];
     */
    
}

-(void)reloadViewByJson:(NSDictionary*)res
{
    NSNumber *resultCodeObj = [res objectForKey:@"ResultCode"];
    if ([resultCodeObj integerValue] >=0)
    {
        self.cmTypes = [res objectForKey:@"Record"];
        [self.tableView reloadData];
    } else {
        NSString *errorStr = [resultCodeObj errorMessage];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Info"
                                                            message:errorStr
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}
@end
