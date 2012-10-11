//
//  NBDetailViewController.m
//  CICCTimer
//
//  Created by nazbot on 12-10-10.
//  Copyright (c) 2012 notabene. All rights reserved.
//

#import "NBDetailViewController.h"

@interface NBDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation NBDetailViewController

@synthesize startTime;
@synthesize endTime;

@synthesize countdownTimer;
@synthesize completeTimer;

@synthesize resetTimerAlert;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem stringValue];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the start and end timers to the current time as a default
    // Timers will be set properly in the viewDidAppear method
    self.startTime = [NSDate date];
    self.endTime = [NSDate date];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

/*
 * When the view appears we want to get the current time/date, calculate the stop date and time and start the timer
 */
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startTimer];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.countdownTimer invalidate];
    self.countdownTimer = nil;
    
    [self.completeTimer invalidate];
    self.completeTimer = nil;
    
}

#pragma mark - Timer Methods

-(void) handleTimerTick
{
    NSDate* currentTime = [NSDate date];
    NSTimeInterval delta = floor([currentTime timeIntervalSinceDate:self.startTime]);
    NSTimeInterval stopTime = floor([self.endTime timeIntervalSinceDate:self.startTime]);
    NSTimeInterval timeRemaining = stopTime - delta;
    
    // Stop the timer when we reach or pass 0 seconds left
    if (timeRemaining >= 0.0) {
        NSLog(@"%f %f %f", delta, stopTime, timeRemaining);
        self.detailDescriptionLabel.text = [NSString stringWithFormat:@"%.0f", timeRemaining];
    } else {
        [self.countdownTimer invalidate];
        self.countdownTimer = nil;
    }
}

-(void) showTimerComplete
{
    NSLog(@"Timer Complete");
    
    self.resetTimerAlert = [[UIAlertView alloc] initWithTitle:@"Reset Timer?" message:@"Would you like to reset the timer?" delegate:self cancelButtonTitle:@"Back" otherButtonTitles:@"Reset", nil];
    [self.resetTimerAlert show];
    
}

/*
 * Invalidate the timers/stop current timers
 * Get the amount of time that should elapse and create the timers
 */
- (void) startTimer
{
    // Stop all timers
    [self.completeTimer invalidate];
    [self.countdownTimer invalidate];
    
    // Calculate the time interval based on the passed in detailItem
    NSTimeInterval countdownInterval = [self.detailItem doubleValue];
    
    //Set the start timer to current timestamp
    self.startTime = [NSDate date];
    self.endTime = [NSDate dateWithTimeIntervalSinceNow:countdownInterval];
    NSTimeInterval completeInterval = [self.endTime timeIntervalSinceDate:self.startTime];
    
    self.completeTimer = [NSTimer scheduledTimerWithTimeInterval:completeInterval target: self selector: @selector(showTimerComplete) userInfo: nil repeats: NO];
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target: self selector: @selector(handleTimerTick) userInfo: nil repeats: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - UIAlertViewDelegate delegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"Cancel");
        [self.navigationController popViewControllerAnimated:YES];
    } else if (buttonIndex == 1) {
        NSLog(@"Reset");
        
        // Reset the label to the starting time
        self.detailDescriptionLabel.text = [self.detailItem stringValue];
        
        // Reset all of the NSTimers to begin the countdown
        [self startTimer];
    }
}

@end
