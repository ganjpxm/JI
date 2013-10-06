//
//  CollectionDetailVC.h
//  JOne
//
//  Created by Johnny on 6/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionDetailVC : UIViewController
@property (weak, nonatomic) NSString *imageName;
@property (weak, nonatomic) IBOutlet UIImageView *imageUi;
- (IBAction)onClose:(id)sender;
@end
