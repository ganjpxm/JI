//
//  SimpleVC.m
//  JOne
//
//  Created by Johnny on 29/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "PropertyListTableVC.h"
#import "FormVC.h"
#import "SimpleTableCell.h"
#import "PropertyListTableDetailVC.h"

@interface PropertyListTableVC ()

@end

@implementation PropertyListTableVC
{
    NSMutableArray *itemNames;
    NSMutableArray *thumbnails;
    NSMutableArray *prepTimes;
    NSArray *searchItemNames;
    NSArray *searchThumbnails;
    NSArray *searchPrepTimes;
    
    BOOL isSelAndroid;
}
@synthesize addBtnItem, formInfos, simpleTV;


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
//    itemNames = [NSMutableArray arrayWithObjects:@"iOS", @"Android", @"Window Phone 8", @"Form View", nil];
//    thumbnails = [NSMutableArray arrayWithObjects:@"Icon_Facebook", @"Icon_Facebook", @"Icon_Facebook", @"Icon_Facebook", nil];
//    prepTimes = [NSMutableArray arrayWithObjects:@"2007", @"2009", @"2010", @"2013", nil];
    
    // Find out the path of recipes.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"recipes" ofType:@"plist"];
    // Load the file content and read the data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    itemNames = [NSMutableArray arrayWithArray:[dict objectForKey:@"RecipeName"]];
    thumbnails = [NSMutableArray arrayWithArray:[dict objectForKey:@"Thumbnail"]];
    prepTimes = [NSMutableArray arrayWithArray:[dict objectForKey:@"PrepTime"]];
    
    
    isSelAndroid = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//--------------------------- Table View -------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchItemNames count];
    } else {
        return [itemNames count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Use default Cell style and simple cell
//    static NSString *cellId = @"SimpleCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }
//    cell.imageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
//    cell.textLabel.text = [itemNames objectAtIndex:indexPath.row];
    
    //Use customize cell and style.
    static NSString *cellId = @"SimpleTableCell";
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.nameLabel.text = [searchItemNames objectAtIndex:indexPath.row];
    } else {
        cell.nameLabel.text = [itemNames objectAtIndex:indexPath.row];
        cell.thumbnailImageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
        cell.prepTimeLabel.text = [prepTimes objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }

    if (indexPath.row == 1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // rows in section 0 should not be selectable
    if ( indexPath.section == 1 ) return nil;
    // first 3 rows in any section should not be selectable
    if ( indexPath.row == 2 ) return nil;
    // By default, allow row to be selected
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *itemNameSel = [itemNames objectAtIndex:indexPath.row];
    if ([itemNameSel isEqualToString:@"iOS"] || [itemNameSel isEqualToString:@"Egg Benedict"]) {
        UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:itemNameSel message:@"Welcome" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [messageAlert show];
    } else if ([itemNameSel isEqualToString:@"Android"] || [itemNameSel isEqualToString:@"Mushroom Risotto"]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (isSelAndroid) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            cell.accessoryType = UITableViewCellAccessoryNone;
            isSelAndroid = NO;
        } else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            isSelAndroid = YES;
        }
    }
    
    if (indexPath.row >= 3) {
        [self performSegueWithIdentifier:@"showDetail" sender:self];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [itemNames removeObjectAtIndex:indexPath.row];
    [thumbnails removeObjectAtIndex:indexPath.row];
    [prepTimes removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    searchItemNames = [itemNames filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.simpleTV indexPathForSelectedRow];
        PropertyListTableDetailVC *destViewController = segue.destinationViewController;
        destViewController.imageName = [thumbnails objectAtIndex:indexPath.row];
    }
}

- (IBAction)addItem:(id)sender {
    UIStoryboard *storyboard = self.storyboard;
    FormVC *formVC = [storyboard instantiateViewControllerWithIdentifier:@"FormVC"];
    [self.navigationController pushViewController:formVC  animated:YES];
}


@end
