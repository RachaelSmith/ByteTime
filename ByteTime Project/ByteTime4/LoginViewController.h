//
//  LoginViewController.h
//  ByteTime1
//
//  Created by Rachael Smith on 12/2/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernamefield;
@property (weak, nonatomic) IBOutlet UITextField *passwordfield;

- (IBAction)loginAction:(id)sender;

- (IBAction)registeraction:(id)sender;



@end
