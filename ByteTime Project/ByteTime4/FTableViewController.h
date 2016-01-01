//
//  FTableViewController.h
//  ByteTime1
//
//  Created by Anna Zhong on 12/5/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FTableViewController : PFQueryTableViewController

- (IBAction)friends:(id)sender;
- (IBAction)tables:(id)sender;

- (IBAction)logout:(id)sender;


@end


