//
//  AppDelegate.m
//  iMustangsEventsV01
//
//  Created by Seals, Shawn on 2/6/12.
//  Copyright (c) 2012 __MSU__. All rights reserved.
//

#import "AppDelegate.h"
#import "Event.h"
#import <EventKit/EventKit.h>
#import "MainViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize eventsArrayForCleanUp;
@synthesize eventsArrayForCalendarCorrection;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize mainViewController = _mainViewController;
@synthesize navigationController;
@synthesize eventAD;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Update database in the event the user deleted an event directly from the calendar.
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    // Set fetch predicate to fetch events that the database shows to be saved to the calendar.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(calendarFlag == 1)"];
    [request setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"localStartDate" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error1 = nil;
    NSUInteger count = [managedObjectContext countForFetchRequest:request error:&error1];
    
    if (count > 0) {
        NSError *error;
        NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
        
        if (mutableFetchResults == nil) {
            // Handle the error.
            NSLog(@"%@", @"mutableFetchResults are nil in AppDelegate.m - applicationWillTerminate.");
        }
        
        self.eventsArrayForCalendarCorrection = mutableFetchResults;
        
        // For each event in the database with calendarFlag = 1, make sure the event is still in the calendar.  Correct the database if it is not. 
        EKEventStore* store = [[EKEventStore alloc] init];
        for (NSInteger i = 0; i < [self.eventsArrayForCalendarCorrection count]; i++) {
            Event *eventToCheck = [self.eventsArrayForCalendarCorrection objectAtIndex:i];
            EKEvent *eventInCalendar = [store eventWithIdentifier:eventToCheck.guid];
            if (eventInCalendar == nil) {
                [eventToCheck setGuid:@""];
                [eventToCheck setCalendarFlag:[NSNumber numberWithBool:NO]];
            }
        }
        [self saveContext];
    }
    
    // Create and load the home view.
    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (!context) {
        // Handle the error.
    }
    
    // Pass the managed object context to the view controller.
    mainViewController.managedObjectContext = context;
    
    UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    
    self.navigationController = aNavigationController;
    
    [_window addSubview:[navigationController view]];
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
    // Saves changes in the application's managed object context before the application terminates.
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    // Set fetch predicate to fetch events that occured over four weeks agd.
    NSDate *today = [NSDate date];
    NSDate *fourWeeksAgo = [today dateByAddingTimeInterval:-86400*28];   // 86400 sec = 1 day
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(localStartDate <= %@)", fourWeeksAgo];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"localStartDate" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if (mutableFetchResults == nil) {
        // Handle the error.
        NSLog(@"%@", @"mutableFetchResults are nil in AppDelegate.m - applicationWillTerminate.");
    }
    
    self.eventsArrayForCleanUp = mutableFetchResults;
    
    // Delete the fetched events.
    for (NSManagedObject *eventForDelete in eventsArrayForCleanUp) {
        [managedObjectContext deleteObject:eventForDelete];
    }
    
    [self saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    
    // Update database in the event the user deleted an event directly from the calendar.
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    // Set fetch predicate to fetch events that the database shows to be saved to the calendar.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(calendarFlag == 1)"];
    [request setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"localStartDate" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error1 = nil;
    NSUInteger count = [managedObjectContext countForFetchRequest:request error:&error1];
    
    if (count > 0) {
        NSError *error;
        NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
        
        if (mutableFetchResults == nil) {
            // Handle the error.
            NSLog(@"%@", @"mutableFetchResults are nil in AppDelegate.m - applicationWillTerminate.");
        }
        
        self.eventsArrayForCalendarCorrection = mutableFetchResults;
        
        // For each event in the database with calendarFlag = 1, make sure the event is still in the calendar.  Correct the database if it is not. 
        EKEventStore* store = [[EKEventStore alloc] init];
        for (NSInteger i = 0; i < [self.eventsArrayForCalendarCorrection count]; i++) {
            Event *eventToCheck = [self.eventsArrayForCalendarCorrection objectAtIndex:i];
            EKEvent *eventInCalendar = [store eventWithIdentifier:eventToCheck.guid];
            if (eventInCalendar == nil) {
                [eventToCheck setGuid:@""];
                [eventToCheck setCalendarFlag:[NSNumber numberWithBool:NO]];
            }
        }
        [self saveContext];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"iMustangsEventsV01" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"iMustangsEventsV01.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
