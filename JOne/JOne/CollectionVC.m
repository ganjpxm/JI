//
//  CollectionVC.m
//  JOne
//
//  Created by Johnny on 6/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "CollectionVC.h"
#import "CollectionHeaderView.h"
#import "CollectionDetailVC.h"
#import <Social/Social.h>

@interface CollectionVC ()
{
    NSArray *photos;
    BOOL shareEnabled;
    NSMutableArray *selectedPhotos;
}
@end

@implementation CollectionVC

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
    
    NSArray *mainDishImages = [NSArray arrayWithObjects:@"egg_benedict", @"full_breakfast", @"ham_and_cheese_panini", @"ham_and_egg_sandwich", @"hamburger", @"instant_noodle_with_egg", @"japanese_noodle_with_pork", @"mushroom_risotto", @"noodle_with_bbq_pork", @"thai_shrimp_cake", @"vegetable_curry", nil];
    NSArray *drinkDessertImages = [NSArray arrayWithObjects:@"angry_birds_cake", @"creme_brelee", @"green_tea", @"starbucks_coffee", @"white_chocolate_donut", nil];
    photos = [NSArray arrayWithObjects:mainDishImages, drinkDessertImages, nil];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    
    selectedPhotos = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [photos count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[photos objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[photos[indexPath.section] objectAtIndex:indexPath.row]];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo_frame"]];

    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame-selected"]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        long l = indexPath.section + 1;
        NSString *title = [[NSString alloc]initWithFormat:@"Group #%li", l];
        headerView.title.text = title;
        UIImage *headerImage = [UIImage imageNamed:@"header_banner"];
        headerView.backgroundImage.image = headerImage;
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPhoto"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        CollectionDetailVC *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        destViewController.imageName = [photos[indexPath.section] objectAtIndex:indexPath.row];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (shareEnabled) {
        return NO;
    } else {
        return YES;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (shareEnabled) {
        // Determine the selected items by using the indexPath
        NSString *selectedPhoto = [photos[indexPath.section] objectAtIndex:indexPath.row];
        // Add the selected item into the array
        [selectedPhotos addObject:selectedPhoto];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (shareEnabled) {
        NSString *deSelectedRecipe = [photos[indexPath.section] objectAtIndex:indexPath.row];
        [selectedPhotos removeObject:deSelectedRecipe];
    }
}

//  - (void)viewDidLoad {
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"recipes" ofType:@"plist"];
//    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
//    photos = [NSMutableArray arrayWithArray:[dict objectForKey:@"Thumbnail"]];
//  }

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return photos.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *identifier = @"Cell";
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    
//    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
//    recipeImageView.image = [UIImage imageNamed:[photos objectAtIndex:indexPath.row]];
//    
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo_frame"]];
//    
//    return cell;
//}

- (IBAction)onShare:(id)sender {
    if (shareEnabled) {
        
        // Post selected photos to Facebook
        if ([selectedPhotos count] > 0) {
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                [controller setInitialText:@"Check out my recipes!"];
                for (NSString *photo in selectedPhotos) {
                    [controller addImage:[UIImage imageNamed:photo]];
                }
                
                [self presentViewController:controller animated:YES completion:Nil];
            }
        }
        
        // Deselect all selected items
        for (NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
        
        // Remove all items from selectedRecipes array
        [selectedPhotos removeAllObjects];
        
        // Change the sharing mode to NO
        shareEnabled = NO;
        self.collectionView.allowsMultipleSelection = NO;
        self.shareBtnItemUi.title = @"Share";
        [self.shareBtnItemUi setStyle:UIBarButtonItemStylePlain];
        
    } else {
        
        // Change shareEnabled to YES and change the button text to DONE
        shareEnabled = YES;
        self.collectionView.allowsMultipleSelection = YES;
        self.shareBtnItemUi.title = @"Upload";
        [self.shareBtnItemUi setStyle:UIBarButtonItemStyleDone];
        
    }
}
@end
