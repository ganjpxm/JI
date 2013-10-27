//
//  JpViewController.h
//  JOne
//
//  Created by Johnny on 26/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

    @property (weak, nonatomic) IBOutlet UITableView *mSampleTV;

    @property(retain,nonatomic) NSMutableArray * mTitles;
    @property(retain,nonatomic) NSMutableArray * mSamples;
    @property(retain,nonatomic) NSDictionary * mIosSampleDic;
@end
