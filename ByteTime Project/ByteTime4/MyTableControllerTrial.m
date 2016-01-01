//
//  MyTableControllerTrial.m
//  ByteTime1
//
//  Created by Anna Zhong on 12/4/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import "MyTableControllerTrial.h"

@interface MyTableControllerTrial ()

@end

@implementation MyTableControllerTrial

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
    
    // Release any cached data, images, etc that aren't in use.
}



#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0xF9/255.0f green:0xF8/255.0f blue:0xF2/255.0f alpha:1];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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


 // Override to customize what kind of query to perform on the class. The default is to query for
 // all objects ordered by createdAt descending.
 - (PFQuery *)queryForTable {
     PFUser *user = [PFUser currentUser];
     PFQuery *query = [PFQuery queryWithClassName:@"Table"];
     [query whereKey:@"owner" equalTo:user.username];
 
 // If Pull To Refresh is enabled, query against the network by default.
 if (self.pullToRefreshEnabled) {
 query.cachePolicy = kPFCachePolicyNetworkOnly;
 }
 
 // If no objects are loaded in memory, we look to the cache first to fill the table
 // and then subsequently do a query against the network.
 if (self.objects.count == 0) {
 query.cachePolicy = kPFCachePolicyCacheThenNetwork;
 }
 
 [query orderByAscending:@"time"];
 
 return query;
 }

int cellHeightM = 2;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {

    NSString *CellIdentifier = [object objectId];
 
    PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"owner"];
    cell.textLabel.textColor=[UIColor clearColor];

    // contact icon
    UILabel *nameContactIcon = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 5.0, 40.0, 40.0)];
    [nameContactIcon setTag:1];
    [nameContactIcon setBackgroundColor:[UIColor clearColor]];
    nameContactIcon.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"UserIconPurpleSmall.png"]];
    [cell.contentView addSubview:nameContactIcon];
    
    // owner label
    UILabel *nameOwner = [[UILabel alloc] initWithFrame:CGRectMake(50.0, 0.0, 300.0, 30.0)];
    [nameOwner setTag:1];
    nameOwner.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];
    nameOwner.textColor=[UIColor colorWithRed:0x66/255.0f green:0x2B/255.0f blue:0x84/255.0f alpha:1];
    [nameOwner setBackgroundColor:[UIColor clearColor]]; // transparent label background
    nameOwner.text = [object objectForKey:@"owner"];
    [cell.contentView addSubview:nameOwner];
    
    // location label
    UILabel *nameLocation = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 14.0, 300.0, 30.0)];
    [nameLocation setTag:1];
    nameLocation.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:14];
    nameLocation.textColor = [UIColor colorWithRed:0x79/255.0f green:0x77/255.0f blue:0x7a/255.0f alpha:1];
    [nameLocation setBackgroundColor:[UIColor clearColor]];
    nameLocation.text = [object objectForKey:@"loctation"];
    [cell.contentView addSubview:nameLocation];
    
    // location icon
    UILabel *nameLocationIcon = [[UILabel alloc] initWithFrame:CGRectMake(50.0, 18.0, 30.0, 30.0)];
    [nameLocationIcon setTag:1];
    [nameLocationIcon setBackgroundColor:[UIColor clearColor]];
    nameLocationIcon.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LocationIconFrame6.png"]];
    [cell.contentView addSubview:nameLocationIcon];
    
    // time label
    UILabel *nameTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.0, 310.0, 30.0)];
    [nameTime setTag:1];
    nameTime.textAlignment = NSTextAlignmentRight;
    [nameTime setBackgroundColor:[UIColor clearColor]];
    nameTime.text = [object objectForKey:@"timeString"];
    nameTime.font = [UIFont fontWithName:@"Opificio-rounded" size:16];
    [cell.contentView addSubview:nameTime];
    
    // date label
    UILabel *nameDate = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 15.0, 310.0, 30.0)];
    [nameDate setTag:1];
    nameDate.textAlignment = NSTextAlignmentRight;
    nameDate.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:13];
    [nameDate setBackgroundColor:[UIColor clearColor]];
    nameDate.text = [object objectForKey:@"datestring"];
    nameDate.textColor = [UIColor colorWithRed:0x79/255.0f green:0x77/255.0f blue:0x7a/255.0f alpha:1];
    [cell.contentView addSubview:nameDate];
    
    // perform the query for members
    NSMutableString *membersArray = [[NSMutableString alloc] init];
    PFQuery *queryMembers = [PFQuery queryWithClassName:@"tableRelation"];
    [queryMembers whereKey:@"tableId" equalTo:cell.reuseIdentifier];
    
    NSArray *people = [[NSArray alloc] init];
    people = [queryMembers findObjects];
    
    for (PFObject *person in people)
    {
        NSString *member = [person objectForKey:@"username"];
        [membersArray appendString:member];
        [membersArray appendString:@"\n"];
    }
    [queryMembers orderByAscending:@"username"];
    int numberMembers = [queryMembers countObjects];
    
    // Members label
    UILabel *nameMembers = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 45.0, 250.0, 20.0)];
    nameMembers.numberOfLines = 0;
    [nameMembers setTag:1];
    nameMembers.textAlignment = NSTextAlignmentLeft;
    [nameMembers setBackgroundColor:[UIColor clearColor]];
    if (numberMembers > 0)
    {
        nameMembers.text = membersArray;
    }
    else{
        nameMembers.text = @"No members have joined this table yet";
    }
    
    [cell.contentView addSubview:nameMembers];
    [nameMembers sizeToFit];
    nameMembers.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:14];
    
    // storing larger value
    if (numberMembers > cellHeightM)
    {
        cellHeightM = numberMembers;
    }
    
    // calculating largest height of the cell
    int expectedHeight = (cellHeightM - 3) * 15 + 110;
    
    // set cell height
    [self.tableView setRowHeight:expectedHeight];


    return cell;
 }



#pragma mark - UITableViewDataSource

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
     UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
     
     PFQuery *table = [PFQuery queryWithClassName:@"Table"];
     [table whereKey:@"idcopy" equalTo:cell.reuseIdentifier];
     [table getFirstObjectInBackgroundWithBlock :^(PFObject *objects, NSError *error) {
         NSLog(@"%@", objects);
         
         [objects deleteInBackground];
         
         //query parse for deleted table's relations
         PFQuery *oldrelations = [PFQuery queryWithClassName:@"tableRelation"];
         [oldrelations whereKey:@"tableId" equalTo:cell.reuseIdentifier];
         [oldrelations findObjectsInBackgroundWithBlock:^(NSArray *relations, NSError *error) {
             
             //delete old table relations
             for (PFObject *relation in relations)
             {
                 [relation deleteInBackground];
             }
         }];
         
         [self performSegueWithIdentifier:@"goHome" sender:self];
         
     }];

 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, and save it to Parse
 }
 }



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}



@end