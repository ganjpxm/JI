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
#import "JqueryMobileVC.h"
#import "WebViewVC.h"
#import "JpConst.h"
#import "UIViewController+MMDrawerController.h"

@interface SampleVC ()

@end

@implementation SampleVC

@synthesize mTitles, mSamples, mIosSampleDic;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    mIosSampleDic = IOS_SAMPLES_DIC;
    mTitles = [[NSMutableArray alloc] initWithArray:[mIosSampleDic allKeys]];
    mSamples = [[NSMutableArray alloc] initWithArray:[mIosSampleDic allValues]];
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
    return [mTitles count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [mTitles objectAtIndex:section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[mSamples[section] componentsSeparatedByString:@","] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"SampleCell";
    
    UITableViewCell * cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    [[cell textLabel] setText:[[mSamples[indexPath.section] componentsSeparatedByString:@","] objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sampleArr = [mSamples[indexPath.section] componentsSeparatedByString:@","];
    NSString *itemNameSel = [sampleArr objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = self.storyboard;
    if ([itemNameSel isEqualToString:@"Objective-C"]) {
        [JpOc testOc];
    } else if ([itemNameSel isEqualToString:@"Web View"]) {
        WebViewVC *webViewVc = [[WebViewVC alloc] init];
        [self.navigationController pushViewController:webViewVc animated:YES];
//        [self.mm_drawerController setCenterViewController:[[UINavigationController alloc] initWithRootViewController:webViewVc] withCloseAnimation:YES completion:nil];
    } else if ([itemNameSel isEqualToString:@"Form"]){
        FormVC *formVC = [storyboard instantiateViewControllerWithIdentifier:@"FormVC"];
        [self.navigationController pushViewController:formVC  animated:YES];
    } else if ([itemNameSel isEqualToString:@"Property List Table"]){
        UIViewController *simpleTableVC = [storyboard instantiateViewControllerWithIdentifier:@"PropertyListTableVC"];
        [self.navigationController pushViewController:simpleTableVC  animated:YES];
    } else if ([itemNameSel isEqualToString:@"Core Data Table"]) {
        UITabBarController *coreDataTableVC = [storyboard instantiateViewControllerWithIdentifier:@"CoreDataTableVC"];
        [self.navigationController pushViewController:coreDataTableVC  animated:YES];
    } else if ([itemNameSel isEqualToString:@"Bottom Tab Bar"]) {
        UITabBarController *tabBarVC = [storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
        [self.navigationController pushViewController:tabBarVC  animated:YES];
    } else if ([itemNameSel isEqualToString:@"Collection View"]) {
        CollectionVC *collectionVC = [storyboard instantiateViewControllerWithIdentifier:@"CollectionVC"];
        [self.navigationController pushViewController:collectionVC  animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //TO-DO
}


@end
