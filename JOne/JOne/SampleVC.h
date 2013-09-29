//
//  JpViewController.h
//  JOne
//
//  Created by Johnny on 26/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

    @property (weak, nonatomic) IBOutlet UITableView *sampleTV;

    @property(retain,nonatomic) NSMutableArray * codes;
    @property(retain,nonatomic) NSMutableArray * xibs;
    @property(retain,nonatomic) NSMutableArray * storyboards;
    @property(retain,nonatomic) NSMutableArray * titles;
@end
