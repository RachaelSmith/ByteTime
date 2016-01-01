//
//  AddFriendViewController.m
//  ByteTime1
//
//  Created by Rachael Smith on 12/4/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import "AddFriendViewController.h"

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)following:(id)sender {
    [self performSegueWithIdentifier:@"following" sender:self];}

- (IBAction)followers:(id)sender {
    [self performSegueWithIdentifier:@"follower" sender:self];}

- (IBAction)addfriend:(id)sender {
    PFUser *user = [PFUser currentUser];
    
    
    //check that user exists
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:_friendname.text];
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (!error && (number > 0)) {
            
            //check that user has not already added friend
            PFQuery *validate = [PFQuery queryWithClassName:@"relationship"];
            [validate whereKey:@"follower" equalTo:user.username];
            [validate whereKey:@"following" equalTo:_friendname.text];
            [validate countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
                //alert user that they have already added friend
                if (number > 0)
                {
                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Oops!" message:@"You're already following this user!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                
                //else add friend
                else
                {
                    PFObject *follow = [PFObject objectWithClassName:@"relationship"];
                    [follow setObject:user.username forKey:@"follower"];
                    [follow setObject:_friendname.text forKey:@"following"];
                    [follow save];
                    [self performSegueWithIdentifier:@"following" sender:self];
                }
            }];
        }
        
        else{
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Oh No!" message:@"There was an error! Please check the spelling of the username (it's case sensitive)." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    
    }];
    
}

- (IBAction)byekeyboard:(id)sender {
[sender resignFirstResponder];}
@end
