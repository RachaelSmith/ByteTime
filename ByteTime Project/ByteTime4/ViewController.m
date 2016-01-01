//
//  ViewController.m
//  ByteTime1
//
//  Created by Rachael Smith on 12/2/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithRed:0xF9/255.0f green:0xF8/255.0f blue:0xF4/255.0f alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)textfield:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)button:(id)sender {
    // format date into date
    NSDate *date = [self.date date];
    NSDateFormatter *formatDate = [NSDateFormatter new];
    [formatDate setDateFormat:@"MMM d, yyyy"];
    NSString *datestring = [formatDate stringFromDate:date];
    
    // format into time
    NSDateFormatter *formatTime = [NSDateFormatter new];
    [formatTime setDateFormat:@"EEE h:mm a"];
    NSString *timeString = [formatTime stringFromDate:date];
    
    PFUser *user = [PFUser currentUser];
    PFObject *newtable = [PFObject objectWithClassName:@"Table"];
    [newtable setObject:user.username forKey:@"owner"];
    [newtable setObject:date forKey:@"time"];
    [newtable setObject:datestring forKey:@"datestring"];
    [newtable setObject:timeString forKey:@"timeString"];
    [newtable setObject:_locationfield.text forKey:@"loctation"];
    [newtable saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error){
           NSString *idstring = [newtable objectId];
            [newtable setObject:idstring forKey:@"idcopy"];
            [newtable save];
            [self performSegueWithIdentifier:@"myTables" sender:self];
        }
    }];
    
    
}

- (IBAction)myTables:(id)sender {
    [self performSegueWithIdentifier:@"myTables" sender:self];
}

- (IBAction)friendsTables:(id)sender {
    [self performSegueWithIdentifier:@"joinedtables" sender:self];
}

@end
