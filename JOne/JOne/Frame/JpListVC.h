//
//  JpListVC.h
//  JOne
//
//  Created by Johnny on 26/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JpListVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableViewList;
}

@property (nonatomic, strong) IBOutlet UITableView *tableViewList;

- (void)viewDidCurrentView;

@end
