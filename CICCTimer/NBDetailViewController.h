//
//  NBDetailViewController.h
//  CICCTimer
//
//  Created by nazbot on 12-10-10.
//  Copyright (c) 2012 notabene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBDetailViewController : UIViewController <UISplitViewControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

// As per http://stackoverflow.com/questions/3220695/nstimer-problem/3220828#3220828 using NSDate's for start and end time
// are better than using a countdown tick due to precision
@property (strong, nonatomic) NSDate* startTime;
@property (strong, nonatomic) NSDate* endTime;

@property (strong, nonatomic) NSTimer* countdownTimer;
@property (strong, nonatomic) NSTimer* completeTimer;

@property (strong, nonatomic) UIAlertView* resetTimerAlert;

-(void) handleTimerTick;
-(void) showTimerComplete;

// Start timers
- (void) startTimer;

@end
