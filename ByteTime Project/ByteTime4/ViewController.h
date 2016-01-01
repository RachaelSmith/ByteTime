//
//  ViewController.h
//  ByteTime1
//
//  Created by Rachael Smith on 12/2/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController

- (IBAction)button:(id)sender;
- (IBAction)myTables:(id)sender;
- (IBAction)friendsTables:(id)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *date;
@property (weak, nonatomic) IBOutlet UITextField *locationfield;
-(IBAction)textfield:(id)sender;
@end
