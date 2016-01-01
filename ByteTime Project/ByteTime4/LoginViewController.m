//
//  LoginViewController.m
//  ByteTime1
//
//  Created by Rachael Smith on 12/2/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    //query parse for old tables
    NSMutableArray *dummyArray = [[NSMutableArray alloc] init];
    PFQuery *oldtables = [PFQuery queryWithClassName:@"Table"];
    [oldtables whereKey:@"time" lessThan:[NSDate date]];
    [oldtables findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        //delete old tables
        for (PFObject *object in objects)
        {
            NSString *post = [object objectId];
            [dummyArray addObject:post];
            [object deleteInBackground];
        }
        
        //query parse for old table relations
        PFQuery *oldrelations = [PFQuery queryWithClassName:@"tableRelation"];
        [oldrelations whereKey:@"tableId" containedIn:dummyArray];
        [oldrelations findObjectsInBackgroundWithBlock:^(NSArray *relations, NSError *error) {
            
            //delete old table relations
            for (PFObject *relation in relations)
            {
                [relation deleteInBackground];
            }
        }];
        
    }];

    self.view.backgroundColor = [UIColor colorWithRed:0xF9/255.0f green:0xF8/255.0f blue:0xF2/255.0f alpha:1];

}

- (void) viewDidAppear:(BOOL)animated {
    PFUser *user = [PFUser currentUser];
    if (user.username != nil) {
        [self performSegueWithIdentifier:@"toregister" sender:self];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    [PFUser logInWithUsernameInBackground:_usernamefield.text password:_passwordfield.text block:^(PFUser *user, NSError *error) {
        if(!error){
            
            NSLog(@"Login!");
            [self performSegueWithIdentifier:@"toregister" sender:self];
        }
        else {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Oh No!" message:@"There was an error with login, please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        }];
     }

- (IBAction)registeraction:(id)sender {
}

- (IBAction)logoutAppYoureDrunk:(UIStoryboardSegue *)unwindSegue{
    
}


@end
