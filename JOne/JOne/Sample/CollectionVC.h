//
//  CollectionVC.h
//  JOne
//
//  Created by Johnny on 6/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionVC : UICollectionViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareBtnItemUi;
- (IBAction)onShare:(id)sender;

@end
