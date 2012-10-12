///
///  NBDetailViewController.h
///  CICCTimer
///
///  Created by nazbot on 12-10-10.
///  Copyright (c) 2012 notabene. All rights reserved.
///
///  Detail view which displays a timer counting down from a preset value
///  When timer completes a dialog popup will be displayed and user can either go back or restart timer

#import <UIKit/UIKit.h>

@interface NBDetailViewController : UIViewController <UISplitViewControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) id detailItem;

/// Timer label to display number of seconds left in the timer
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

/// As per http://stackoverflow.com/questions/3220695/nstimer-problem/3220828#3220828 using NSDate's for start and end time
/// are better than using a countdown tick due to precision
@property (strong, nonatomic) NSDate* startTime;
@property (strong, nonatomic) NSDate* endTime;

/// NSTimer, repeating that calls handleTimerTick method
@property (strong, nonatomic) NSTimer* countdownTimer;

/// Dialog box to be shown when the timer finishes countdown
@property (strong, nonatomic) UIAlertView* resetTimerAlert;

/// Method that updates the countdown label, and fires the dialog box when timer finishes counting down
-(void) handleTimerTick;

/// Helper method to show the dialog box
-(void) showTimerComplete;

/// Start timers
- (void) startTimer;

@end
