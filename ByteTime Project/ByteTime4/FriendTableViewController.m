//
//  FriendTableViewController.m
//  ByteTime1
//
//  Created by Rachael Smith on 12/4/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import "FriendTableViewController.h"

@interface FriendTableViewController ()

@end


@implementation FriendTableViewController

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"relationship";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"following";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
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
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor = [UIColor colorWithRed:0xF9/255.0f green:0xF8/255.0f blue:0xF2/255.0f alpha:1];
    
    // UIBarButtonItem *backbutton =  [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:nil action:nil];

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
 PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
     [query whereKey:@"follower" equalTo:[PFUser currentUser].username];
     


 // If Pull To Refresh is enabled, query against the network by default.
 if (self.pullToRefreshEnabled) {
 query.cachePolicy = kPFCachePolicyNetworkOnly;
 }

 // If no objects are loaded in memory, we look to the cache first to fill the table
 // and then subsequently do a query against the network.
 if (self.objects.count == 0) {
 query.cachePolicy = kPFCachePolicyCacheThenNetwork;
 }
 
 [query orderByAscending:@"following"];
 
 return query;
 }



 // Override to customize the look of a cell representing an object. The default is to display
 // a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
 // and the imageView being the imageKey in the object.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
     NSString *CellIdentifier = [object objectForKey:@"following"];
 
 PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 if (cell == nil) {
 cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

 }

     UIImage *cellImage = [UIImage imageNamed:@"TickCorrect.png"];
     cell.imageView.image = cellImage;
     cell.textLabel.text = [object objectForKey:@"following"];
     cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
     
     // display only used cells
     self.tableView.tableFooterView = [UIView new];
     
     // change font of text in table
     cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16];
    
 
 return cell;
 }


/*
 // Override if you need to change the ordering of objects in the table.
 - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
 return [self.objects objectAtIndex:indexPath.row];
 }
 */

/*
 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */

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
     
     // Delete the object from Parse and reload the table view
     PFUser *user = [PFUser currentUser];
     PFQuery *deletefriend = [PFQuery queryWithClassName:@"relationship"];
     [deletefriend whereKey:@"follower" equalTo:user.username];
     [deletefriend whereKey:@"following" equalTo:cell.reuseIdentifier];
     [deletefriend getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
         [object deleteInBackground];
         NSLog(@"here");
         [self performSegueWithIdentifier:@"goHome" sender:self]; }];
 }
      else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, and save it to Parse
 }
 }


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}
@end
