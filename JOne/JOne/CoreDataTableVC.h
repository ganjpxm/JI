//
//  TableViewController.h
//  JOne
//
//  Created by Johnny on 6/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataTableVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)onAdd:(id)sender;

@end
