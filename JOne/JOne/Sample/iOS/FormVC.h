//
//  FormViewController.h
//  JOne
//
//  Created by Johnny on 27/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormVC : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewUi;
@property (weak, nonatomic) IBOutlet UILabel *lableUi;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUi;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControlUi;
@property (weak, nonatomic) IBOutlet UISlider *sliderUi;
@property (weak, nonatomic) IBOutlet UISwitch *switchUi;
@property (weak, nonatomic) IBOutlet UIStepper *stepperUi;
@property (weak, nonatomic) IBOutlet UIProgressView *progressViewUi;
@property (weak, nonatomic) IBOutlet UITextView *textViewUi;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerUi;

@property (strong, nonatomic) NSString *itemName;
@property (strong) NSManagedObject *cmType;

- (IBAction)onCancel:(id)sender;
- (IBAction)onSave:(id)sender;
@end
