//
//  AddFriendViewController.h
//  ByteTime1
//
//  Created by Rachael Smith on 12/4/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AddFriendViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction)following:(id)sender;
- (IBAction)followers:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *friendname;
- (IBAction)addfriend:(id)sender;

- (IBAction)byekeyboard:(id)sender;


@end
