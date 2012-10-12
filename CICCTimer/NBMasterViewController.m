///
///  NBMasterViewController.m
///  CICCTimer
///
///  Created by nazbot on 12-10-10.
///  Copyright (c) 2012 notabene. All rights reserved.
///

#import "NBMasterViewController.h"

#import "NBDetailViewController.h"

@interface NBMasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation NBMasterViewController

@synthesize timerArray;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

/**
 * Create the datasource for the tableview - for now just an array of arrays
 * Each element is an NSNumber containing a float value that represent how much time the detail view timer should count down from
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the values for the table row/timers from the plist 'TimerTableArray' in Supporting Files folder
    NSString *timerValuesPath = [[NSBundle mainBundle] pathForResource:@"TimerTableArray" ofType:@"plist"];
    self.timerArray = [[NSArray alloc] initWithContentsOfFile:timerValuesPath];
    
    // Boilerplate to setup the split view
    self.detailViewController = (NBDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

/**
 * Clear and release memory if low memory warning called
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View
/** 
 * Number of sections in datasource
 * @param tableView tableView for delegate method
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.timerArray count];
}

/**
 * Number of rows in each section
 * @param tableView tableView for delegate method
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* rowArray = [self.timerArray objectAtIndex:section];
    return [rowArray count];
}

/**
 * Create a header for each section.  Format is just section number.  Better if it's human readable so add 1 to this value
 * @param tableView tableView for delegate method
 * @param section Section for this title
 */
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* sectionName = [NSString stringWithFormat:@"Section %d", (section+1)];
    return sectionName;
}

/**
 * Update cell with the timer value for that section/row
 * @param tableView tableView for delegate method
 * @param indexPath indexPath of this cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

/**
 * Method to allow or prevent editing of cells.  In this case we do not want the user to be able to edit the cells
 * @param tableView tableView for delegate method
 * @param indexPath Index path to check for editability
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*
 * We do not want the user to be able to move cells
 * @param tableView tableView for delegate method
 * @param indexPath The index path we want to check we are allowed to move or not
 */
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

/*
 * If the user taps a cell then present and update the detail view
 * This is only used in the ipad version (currently not supported)
 * @param tableView tableView for delegate method
 * @param indexPath Index Path user selected/tapped
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSArray* sectionArray = [self.timerArray objectAtIndex:indexPath.section];
        NSNumber* currentCountdownNumber = [sectionArray objectAtIndex:indexPath.row];
        
        NSLog(@"%@", [currentCountdownNumber stringValue]);
        self.detailViewController.detailItem = currentCountdownNumber;
    }
}

/**
 * Segue to the detail view, using the value of the section/row of the cell that was tapped to pass in the
 * time to count down from
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray* sectionArray = [self.timerArray objectAtIndex:indexPath.section];
        NSNumber* currentCountdownNumber = [sectionArray objectAtIndex:indexPath.row];
        
        NSLog(@"%@", [currentCountdownNumber stringValue]);
        
        [[segue destinationViewController] setDetailItem:currentCountdownNumber];
    }
}

/*
 * Update the cell at the specified indexPath
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];
    NSArray* sectionArray = [self.timerArray objectAtIndex:indexPath.section];
    NSNumber* currentCountdownNumber = [sectionArray objectAtIndex:indexPath.row];

    cell.textLabel.text = [currentCountdownNumber stringValue];
}

@end
