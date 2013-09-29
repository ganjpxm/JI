//
//  SimpleVC.m
//  JOne
//
//  Created by Johnny on 29/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "SimpleTableVC.h"
#import "FormVC.h"

@interface SimpleTableVC ()

@end

@implementation SimpleTableVC
{
    NSArray *itemNames;
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
    itemNames = [NSArray arrayWithObjects:@"iOS", @"Android", @"Window Phone 8", @"Form View", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------- Table View -------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"SimpleCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.imageView.image = [UIImage imageNamed:@"Icon_Facebook"];


    cell.textLabel.text = [itemNames objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *itemNameSel = [itemNames objectAtIndex:indexPath.row];
    if ([itemNameSel isEqualToString:@"Form View"]){
        UIStoryboard *storyboard = self.storyboard;
        FormVC *formVC = [storyboard instantiateViewControllerWithIdentifier:@"FormVC"];
        formVC.itemName = [itemNames objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:formVC  animated:YES];
    } else if ([itemNameSel isEqualToString:@"iOS"]) {
        UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:itemNameSel message:@"Welcome" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [messageAlert show];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showForm"]) {
        NSIndexPath *indexPath = [self.simpleTV indexPathForSelectedRow];
        FormVC *destViewController = segue.destinationViewController;
        destViewController.itemName = [itemNames objectAtIndex:indexPath.row];
    }
}

@end
