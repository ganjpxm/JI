//
//  JpSlideSwitchVC.h
//  JOne
//
//  Created by Johnny on 26/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSlideSwitchView.h"
#import "JpListVC.h"
#import "JpDrawerVC.h"

@interface JpSlideSwitchVC : UIViewController<SUNSlideSwitchViewDelegate>
{
    MMSlideSwitchView *mSlideSwitchView;
}

@property (nonatomic, strong) IBOutlet MMSlideSwitchView *slideSwitchView;
@property (nonatomic, strong) NSMutableArray *mVCs;
@property (nonatomic, strong) NSDictionary *mArticleDic;

@end
