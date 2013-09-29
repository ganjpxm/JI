//
//  FormViewController.h
//  JOne
//
//  Created by Johnny on 27/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormVC : UIViewController

@property (strong, nonatomic) IBOutlet UIView *nameLbl;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (strong, nonatomic) NSString *itemName;

@end
