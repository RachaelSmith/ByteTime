//
//  RegisterViewController.m
//  ByteTime1
//
//  Created by Rachael Smith on 12/2/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0xF9/255.0f green:0xF8/255.0f blue:0xF2/255.0f alpha:1];
}

- (void) viewDidAppear:(BOOL)animated {
    PFUser *user = [PFUser currentUser];
    if (user.username != nil) {
        [self performSegueWithIdentifier:@"pushlogin" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerAction:(id)sender {
    [_usernamefield resignFirstResponder];
    [_emailfield resignFirstResponder];
    [_passwordfield resignFirstResponder];
    [_confirmpasswordfield resignFirstResponder];
    
    
    [self checkFieldsComplete];
}

- (void) checkFieldsComplete{
    if ([_usernamefield.text isEqualToString:@""] ||[_emailfield.text isEqualToString:@""] || [_passwordfield.text isEqualToString:@""] || [_confirmpasswordfield.text isEqualToString:@""]){
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Oh No!" message:@"You didn't fill out all of the fields!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self checkPasswordsMatch];
    }
}

- (void) checkPasswordsMatch {
    if (![_passwordfield.text isEqualToString:_confirmpasswordfield.text]) {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Oh No!" message:@"Passwords do not match." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self registerNewUser];
    }
}

-(void) registerNewUser {
    PFUser *newUser = [PFUser user];
    newUser.username = _usernamefield.text;
    newUser.email = _emailfield.text;
    newUser.password = _passwordfield.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    
    if(succeeded) {
        [self performSegueWithIdentifier:@"pushlogin" sender:self];
    }
    else{
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Oh No!" message:@"There was an error, try registering under a different username!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    }];
}

@end
