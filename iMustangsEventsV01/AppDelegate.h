//
//  AppDelegate.h
//  iMustangsEventsV01
//
//  Created by Seals, Shawn on 2/6/12.
//  Copyright (c) 2012 __MSU__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@class Event;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableArray *eventsArrayForCleanUp;
    NSMutableArray *eventsArrayForCalendarCorrection;
    UINavigationController *navigationController;
    Event *eventAD;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *eventsArrayForCleanUp;
@property (strong, nonatomic) NSMutableArray *eventsArrayForCalendarCorrection;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) Event *eventAD;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) MainViewController *mainViewController;

@end
