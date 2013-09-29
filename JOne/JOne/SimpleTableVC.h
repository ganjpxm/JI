//
//  SimpleVC.h
//  JOne
//
//  Created by Johnny on 29/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *simpleTV;

@end
