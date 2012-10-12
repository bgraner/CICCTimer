///
///  NBMasterViewController.h
///  CICCTimer
///
///  Created by nazbot on 12-10-10.
///  Copyright (c) 2012 notabene. All rights reserved.
///
///  TableViewController/SplitView controller that displays the timer times for a user to select
///  The values for the tableview are taken from 'TimerTableArray.plist' in Supporting Files folder

#import <UIKit/UIKit.h>

@class NBDetailViewController;

@interface NBMasterViewController : UITableViewController

/// Detail view controller that user can navigate to from tableview
@property (strong, nonatomic) NBDetailViewController *detailViewController;

/// Array to store values for timer, datasource for tableview
@property (strong, nonatomic) NSArray *timerArray;

@end
