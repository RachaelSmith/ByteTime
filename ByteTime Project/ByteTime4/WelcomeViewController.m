//
//  WelcomeViewController.m
//  ByteTime1
//
//  Created by Rachael Smith on 12/4/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

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
	// Do any additional setup after loading the view
    
    

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (IBAction)friends:(id)sender {
[self performSegueWithIdentifier:@"friends" sender:self];}

- (IBAction)tables:(id)sender {
 [self performSegueWithIdentifier:@"tables" sender:self];
}
- (IBAction)goHomeAppYoureDrunk:(UIStoryboardSegue *)unwindSegue
{
}

@end
