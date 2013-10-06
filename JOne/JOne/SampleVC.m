//
//  JpViewController.m
//  JOne
//
//  Created by Johnny on 26/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "SampleVC.h"
#import "JpOc.h"
#import "FormVC.h"
#import "PropertyListTableVC.h"
#import "CollectionVC.h"

@interface SampleVC ()

@end

@implementation SampleVC

@synthesize codes, xibs, storyboards, titles;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.codes = [[NSMutableArray alloc] initWithObjects:@"Objective-C", @"UI", nil];
    self.xibs = [[NSMutableArray alloc] initWithObjects:@"Table View",@"Collection View", nil];
    self.storyboards = [[NSMutableArray alloc] initWithObjects:@"Form",@"Property List Table",@"Core Data Table",@"Collection View",@"Tab Bar : Web View", nil];
    
    self.titles = [[NSMutableArray alloc] initWithObjects:@"Code",@"Xib",@"Storyboard", nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//-------------------------------------- TableView ---------------------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [titles count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:
            return [titles objectAtIndex:section];
        case 1:
            return [titles objectAtIndex:section];
        case 2:
            return [titles objectAtIndex:section];
            
        default:
            return @"Unknown";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:
            return [codes count];
        case 1:
            return [xibs count];
        case 2:
            return [storyboards count];

        default:
            return 0;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"SampleCell";
    
    UITableViewCell * cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    switch(indexPath.section)
    {
        case 0:
            [[cell textLabel] setText:[codes objectAtIndex:indexPath.row]];
            break;
        case 1:
            [[cell textLabel] setText:[xibs objectAtIndex:indexPath.row]];
            break;
        case 2:
            [[cell textLabel] setText:[storyboards objectAtIndex:indexPath.row]];
            break;
            
        default:
            [[cell textLabel] setText:@"Unknown"];
            
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *itemNameSel;
    if( indexPath.section == 0 ) {
        itemNameSel = [codes objectAtIndex:indexPath.row];
        if ([itemNameSel isEqualToString:@"Objective-C"]) {
            [JpOc testOc];
        }
        [JpOc testOc];
    } else if( indexPath.section == 1 ) {
        itemNameSel = [xibs objectAtIndex:indexPath.row];
    } else if( indexPath.section == 2 ) {
        itemNameSel = [storyboards objectAtIndex:indexPath.row];
        UIStoryboard *storyboard = self.storyboard;
        if ([itemNameSel isEqualToString:@"Form"]){
            FormVC *formVC = [storyboard instantiateViewControllerWithIdentifier:@"FormVC"];
            [self.navigationController pushViewController:formVC  animated:YES];
        } else if ([itemNameSel isEqualToString:@"Property List Table"]){
            UIViewController *simpleTableVC = [storyboard instantiateViewControllerWithIdentifier:@"PropertyListTableVC"];
            [self.navigationController pushViewController:simpleTableVC  animated:YES];
        } else if ([itemNameSel isEqualToString:@"Core Data Table"]) {
            UITabBarController *coreDataTableVC = [storyboard instantiateViewControllerWithIdentifier:@"CoreDataTableVC"];
            [self.navigationController pushViewController:coreDataTableVC  animated:YES];
        } else if ([itemNameSel isEqualToString:@"Tab Bar : Web View"]) {
            UITabBarController *tabBarVC = [storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
            [self.navigationController pushViewController:tabBarVC  animated:YES];
        } else if ([itemNameSel isEqualToString:@"Collection View"]) {
            CollectionVC *collectionVC = [storyboard instantiateViewControllerWithIdentifier:@"CollectionVC"];
            [self.navigationController pushViewController:collectionVC  animated:YES];
        }
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //TO-DO
}


@end
