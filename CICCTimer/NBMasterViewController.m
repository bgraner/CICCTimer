//
//  NBMasterViewController.m
//  CICCTimer
//
//  Created by nazbot on 12-10-10.
//  Copyright (c) 2012 notabene. All rights reserved.
//

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the values for the timer array
    self.timerArray = [[NSArray alloc] initWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithFloat:5.0],
                                                                                 [NSNumber numberWithFloat:7.0],
                                                                                 [NSNumber numberWithFloat:2.0],nil],
                                                       [NSArray arrayWithObjects:[NSNumber numberWithFloat:10.0],
                                                                                 [NSNumber numberWithFloat:6.0],
                                                                                 [NSNumber numberWithFloat:4.0],nil],
                                                       [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0],
                                                                                 [NSNumber numberWithFloat:9.0],
                                                                                 [NSNumber numberWithFloat:22.0],nil],
                                                       nil];
    
    self.detailViewController = (NBDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        //self.detailViewController.detailItem = object;
    }
}

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

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];
    NSArray* sectionArray = [self.timerArray objectAtIndex:indexPath.section];
    NSNumber* currentCountdownNumber = [sectionArray objectAtIndex:indexPath.row];
    
    NSLog(@"%@", [currentCountdownNumber stringValue]);
    cell.textLabel.text = [currentCountdownNumber stringValue];
}

@end
