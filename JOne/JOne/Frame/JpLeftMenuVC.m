//
//  JpLeftMenuVC.m
//  JOne
//
//  Created by Johnny on 26/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "JpLeftMenuVC.h"
#import "JpSlideSwitchVC.h"
#import "UIViewController+MMDrawerController.h"
#import "JpConst.h"
#import "JpUtil.h"
#import "SampleVC.h"
#import "JqueryMobileVC.h"

@interface JpLeftMenuVC ()

@end

@implementation JpLeftMenuVC

@synthesize mIosSampleNC,mJqueryMobileSampleNC,articleCategories,samples,settings,titles;


#pragma mark - Controller init method

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        articleCategories = [[NSMutableArray alloc] initWithArray:[ARTICLES_CATEGORIES componentsSeparatedByString:@","]];
        samples = [[NSMutableArray alloc] initWithArray:[SAMPLE_CATEGORIES componentsSeparatedByString:@","]];
        settings =[[NSMutableArray alloc] initWithArray:[SETTINGS componentsSeparatedByString:@","]];
        titles = [[NSMutableArray alloc] initWithArray:[LEFT_MENU_TITLES componentsSeparatedByString:@","]];
        
        self.mNavSlideSwitchNC = [[JpUtil getArticleCategoryAndNCDic] objectForKey:articleCategories[0]];
    }
    return self;
}
- (void)setupUI
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.title = @"Menu";
}

#pragma mark - View loading method
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - table datasource proxy method
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
            return [articleCategories count];
        case 1:
            return [samples count];
        case 2:
            return [settings count];
            
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
            [[cell textLabel] setText:[articleCategories objectAtIndex:indexPath.row]];
            break;
        case 1:
            [[cell textLabel] setText:[samples objectAtIndex:indexPath.row]];
            break;
        case 2:
            [[cell textLabel] setText:[settings objectAtIndex:indexPath.row]];
            break;
            
        default:
            [[cell textLabel] setText:@"Unknown"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *itemNameSel;
    if(indexPath.section == 0){
        itemNameSel = [articleCategories objectAtIndex:indexPath.row];
        self.mNavSlideSwitchNC = [[JpUtil getArticleCategoryAndNCDic] objectForKey:itemNameSel];
        [self.mm_drawerController setCenterViewController:self.mNavSlideSwitchNC withCloseAnimation:YES completion:nil];
    } else if(indexPath.section == 1) {
        itemNameSel = [samples objectAtIndex:indexPath.row];
        if ([itemNameSel isEqual: @"iOS"]) {
            UIStoryboard *sampleIphoneSB=[UIStoryboard storyboardWithName:@"Sample-iPhone" bundle:nil];
            if (!mIosSampleNC) {
                SampleVC *sampleVC = [sampleIphoneSB instantiateViewControllerWithIdentifier:@"SampleVC"];
                mIosSampleNC = [[UINavigationController alloc] initWithRootViewController:sampleVC];
             }
            [self.mm_drawerController setCenterViewController:mIosSampleNC withCloseAnimation:YES completion:nil];
        } else if ([itemNameSel isEqualToString:@"jQuery Mobile"]) {
            if (!mJqueryMobileSampleNC) {
                JqueryMobileVC *jqmVc = [[JqueryMobileVC alloc] init];
                mJqueryMobileSampleNC = [[UINavigationController alloc] initWithRootViewController:jqmVc];
            }
            [self.mm_drawerController setCenterViewController:mJqueryMobileSampleNC withCloseAnimation:YES completion:nil];
        }
    } else if(indexPath.section == 2) {
        itemNameSel = [settings objectAtIndex:indexPath.row];
    }
}

#pragma mark - destroy memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
