//
//  FTableViewController.m
//  ByteTime1
//
//  Created by Anna Zhong on 12/5/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import "FTableViewController.h"

@interface FTableViewController ()

@end

@implementation FTableViewController


- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"Table";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 10;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}


#pragma mark - UIViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    // set background color
    self.view.backgroundColor = [UIColor colorWithRed:0xF9/255.0f green:0xF8/255.0f blue:0xF2/255.0f alpha:1];
    
    /*
    // change status bar to white
    -(UINavigationBar.barStyle
    {
        return UIBarStyleBlackTranslucent;
    }
     */
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}


// Customize query performed on the class
- (PFQuery *)queryForTable {
    
    // Create array of objects to be passed through a query
    NSMutableArray *dummyArray = [[NSMutableArray alloc] init];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Table"];
    PFUser *user = [PFUser currentUser];
    PFQuery *getfriends = [PFQuery queryWithClassName:@"relationship"];
    
    // Get all the people that user is following and store in an array
    [getfriends whereKey:@"follower" equalTo:user.username];
    NSArray *objects = [[NSArray alloc] init];
    objects = [getfriends findObjects];
    
    // Save username of those people in dummyArray
    for (PFObject *object in objects)
    {
        PFObject *post = [object objectForKey:@"following"];
        [dummyArray addObject:post];
    }
    
    // Add your own username for newsfeed
    [dummyArray addObject:user.username];
    
    // Query for tables created by you and your friends
    [query whereKey:@"owner" containedIn:dummyArray];
    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    // Sort the query
    [query orderByAscending:@"time"];
    
    return query;
    
}

// Initialize variable for calculating dynamic cell height
int cellHeightF = 2;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    // Cell identifier
    NSString *CellIdentifier = [object objectId];
    
    PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        // Configure join button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        UIImage *green = [UIImage imageNamed:@"Button.png"];
        [button setTitle:@"join" forState:UIControlStateNormal];
        [button setFrame:CGRectMake(13.0, 10.0, 50, 20)];
        [button setTag:101];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16];
        [button setBackgroundImage:green forState:(UIControlStateNormal)];
        [[cell contentView] addSubview:button];
    }

    // For tracking purposes
    cell.textLabel.text = [object objectForKey:@"owner"];
    cell.textLabel.textColor=[UIColor clearColor];  // Transparent color; not displayed
    
    // Customize appearance of cell
   
    // Owner label
    UILabel *nameOwner = [[UILabel alloc] initWithFrame:CGRectMake(109.0, 0.0, 300.0, 30.0)];
    [nameOwner setTag:1];
    [nameOwner setBackgroundColor:[UIColor clearColor]];
    nameOwner.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];
    nameOwner.text = [object objectForKey:@"owner"];
    nameOwner.textColor=[UIColor colorWithRed:0x66/255.0f green:0x2B/255.0f blue:0x84/255.0f alpha:1];
    [cell.contentView addSubview:nameOwner];
    
    // Contact icon
    UILabel *nameContactIcon = [[UILabel alloc] initWithFrame:CGRectMake(70.0, 5.0, 40.0, 40.0)];
    [nameContactIcon setTag:1];
    [nameContactIcon setBackgroundColor:[UIColor clearColor]];
    nameContactIcon.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"UserIconPurpleSmall.png"]];
    [cell.contentView addSubview:nameContactIcon];
    
    // Location label
    UILabel *nameLocation = [[UILabel alloc] initWithFrame:CGRectMake(119.0, 14.0, 300.0, 30.0)];
    [nameLocation setTag:1];
    [nameLocation setFont:[UIFont systemFontOfSize:14.0]];
    [nameLocation setBackgroundColor:[UIColor clearColor]];
    nameLocation.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:14];
    nameLocation.text = [object objectForKey:@"loctation"];
    nameLocation.textColor = [UIColor colorWithRed:0x79/255.0f green:0x77/255.0f blue:0x7a/255.0f alpha:1];
    [cell.contentView addSubview:nameLocation];
    
    // Location icon
    UILabel *nameLocationIcon = [[UILabel alloc] initWithFrame:CGRectMake(109.0, 18.0, 30.0, 30.0)];
    [nameLocationIcon setTag:1];
    [nameLocationIcon setBackgroundColor:[UIColor clearColor]]; 
    nameLocationIcon.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LocationIconFrame6.png"]];
    [cell.contentView addSubview:nameLocationIcon];
    
    // Time label
    UILabel *nameTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.0, 307.0, 30.0)];
    [nameTime setTag:1];
    [nameTime setBackgroundColor:[UIColor clearColor]];
    nameTime.textAlignment = NSTextAlignmentRight;
    nameTime.text = [object objectForKey:@"timeString"];
    nameTime.font = [UIFont fontWithName:@"Opificio-rounded" size:16];
    [cell.contentView addSubview:nameTime];
    
    // Date label
    UILabel *nameDate = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 15.0, 307.0, 30.0)];
    [nameDate setTag:1];
    [nameDate setBackgroundColor:[UIColor clearColor]];
    nameDate.textAlignment = NSTextAlignmentRight;
    nameDate.text = [object objectForKey:@"datestring"];
    nameDate.textColor = [UIColor colorWithRed:0x79/255.0f green:0x77/255.0f blue:0x7a/255.0f alpha:1];
    nameDate.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:13];
    [cell.contentView addSubview:nameDate];
    
    // Perform the query for members of the table in each cell
    
    // Create array to store names in
    NSMutableString *membersArray = [[NSMutableString alloc] init];
    
    // Query for all the people who have joined the table
    PFQuery *queryMembers = [PFQuery queryWithClassName:@"tableRelation"];
    [queryMembers whereKey:@"tableId" equalTo:cell.reuseIdentifier];
    
    // Save them in an array
    NSArray *people = [[NSArray alloc] init];
    people = [queryMembers findObjects];
    
    // Save usernames in a string with line breaks
    for (PFObject *person in people)
    {
        NSString *member = [person objectForKey:@"username"];
        [membersArray appendString:member];
        [membersArray appendString:@"\n"];
    }
    [queryMembers orderByAscending:@"username"];
    
    // Count the number of usernames returned in query
    int numberMembers = [queryMembers countObjects];

    // Create members label
    UILabel *nameMembers = [[UILabel alloc] initWithFrame:CGRectMake(74.0, 45.0, 250.0, 20.0)];
    nameMembers.numberOfLines = 0;  // allows for multiple lines to be printed
    nameMembers.textAlignment = NSTextAlignmentLeft;
    nameMembers.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:14];
    [nameMembers setTag:1];
    [nameMembers setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:nameMembers];
    
    // Print members of table
    if (numberMembers > 0)
    {
        nameMembers.text = membersArray;
    }
    else{
        nameMembers.text = @"No members have joined this table yet";
    }
    [nameMembers sizeToFit];
    
    // To set cell height to largest cell (i.e. cell with most members)
    
    // As each members array is queried, save larger number
    if (numberMembers > cellHeightF)
    {
        cellHeightF = numberMembers;
    }
    
    // Calculate largest height of the cell
    int expectedHeight = (cellHeightF - 3) * 15 + 110;
    
    // Set cell height
    [self.tableView setRowHeight:expectedHeight];
    
    return cell;
}



#pragma mark - UITableViewDataSource


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)buttonPressed:(UIButton *)button {
    
    // Configure button action
    CGPoint buttonPosition = [button convertPoint:[button center] toView:[self tableView]];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    // Check that user has not already joined
    PFUser *user = [PFUser currentUser];
    PFQuery *validate = [PFQuery queryWithClassName:@"tableRelation"];
    BOOL cmp = ([cell.textLabel.text isEqualToString:user.username]);
    [validate whereKey:@"tableId" equalTo:cell.reuseIdentifier];
    [validate whereKey:@"username" equalTo:user.username];
    [validate countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (number > 0)
        {
            // Alert user that they have already joined
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Oops!" message:@"You already joined this table." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if (cmp)
        {
            // Alert user that they cannot join their own table
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Oops!" message:@"This is your table." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            // Join table and alert user
            PFObject *follow = [PFObject objectWithClassName:@"tableRelation"];
            [follow setObject:cell.reuseIdentifier forKey:@"tableId"];
            [follow setObject:user.username forKey:@"username"];
            [follow save];
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Awesome!" message:@"You have successfully joined this table." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
    
}

- (IBAction)goHomeAppYoureDrunk:(UIStoryboardSegue *)unwindSegue{
    
}


- (IBAction)tables:(id)sender {
    [self performSegueWithIdentifier:@"tables" sender:self];}



- (IBAction)friends:(id)sender {
    [self performSegueWithIdentifier:@"friends" sender:self];}



- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];}

@end