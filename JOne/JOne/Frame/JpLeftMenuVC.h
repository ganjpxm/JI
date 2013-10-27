//
//  JpLeftMenuVC.h
//  JOne
//
//  Created by Johnny on 26/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JpLeftMenuVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableViewLeft;
@property (nonatomic, strong) IBOutlet UINavigationController *mNavSlideSwitchNC;
@property (nonatomic, strong) IBOutlet UINavigationController *mIosSampleNC;
@property (nonatomic, strong) IBOutlet UINavigationController *mJqueryMobileSampleNC;

@property(retain,nonatomic) NSMutableArray * articleCategories;
@property(retain,nonatomic) NSMutableArray * samples;
@property(retain,nonatomic) NSMutableArray * settings;
@property(retain,nonatomic) NSMutableArray * titles;

@end
