//
//  NBMasterViewController.h
//  CICCTimer
//
//  Created by nazbot on 12-10-10.
//  Copyright (c) 2012 notabene. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBDetailViewController;

@interface NBMasterViewController : UITableViewController

@property (strong, nonatomic) NBDetailViewController *detailViewController;

// Array to store values for timer
@property (strong, nonatomic) NSArray *timerArray;

@end
