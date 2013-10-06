//
//  SimpleVC.h
//  JOne
//
//  Created by Johnny on 29/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyListTableVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *simpleTV;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBtnItem;

@property (strong) NSMutableArray *formInfos;

- (IBAction)addItem:(id)sender;

@end
