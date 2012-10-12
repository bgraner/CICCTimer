///
///  NBAppDelegate.h
///  CICCTimer
///
///  Created by nazbot on 12-10-10.
///  Copyright (c) 2012 notabene. All rights reserved.
///
///  Application to demonstrate technical proficiency
///  Specs can be found at http://www.notabenestudios.com/cicc/timer/requirements.html
///  Presents tableview with 3 sections, each section containing 3 items
///  Tapping on any cell takes you to a detail view which will start a countdown timer

#import <UIKit/UIKit.h>

@interface NBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
