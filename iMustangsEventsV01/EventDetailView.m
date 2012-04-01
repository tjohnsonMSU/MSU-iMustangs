//
//  EventDetailView.m
//  iMustangsEventsV01
//
//  Created by Seals, Shawn on 2/9/12.
//  Copyright (c) 2012 __MSU__. All rights reserved.
//

#import "EventDetailView.h"
#import "Event.h"
#import <EventKit/EventKit.h>
#import "AppDelegate.h"

@implementation EventDetailView

@synthesize backButton;
@synthesize eventEDV;
@synthesize addToCalendarButton;
@synthesize titleField;
@synthesize dateField;
@synthesize timeField;
@synthesize locationField;
@synthesize addEventToCalendarLabel;

- (IBAction)backButtonPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)addEventToCalendar:(id)sender {
    // If user has selected to save an event to the calendar.
    if ([eventEDV.calendarFlag intValue] == 0) {
        // Access to managedObjectContext for saving changes to calendarFlag.
        AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *managedObjectContextEDV = appDelegate.managedObjectContext;
        
        // Add the event to the calendar.
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        
        EKEvent *eventEK = [EKEvent eventWithEventStore:eventStore];
        
        NSMutableArray *myAlarmsArray = [[NSMutableArray alloc] init];
        
        // Set the reminder alarms for the event.
        EKAlarm *alarm1 = [EKAlarm alarmWithRelativeOffset:-3600]; // 1 Hour
        EKAlarm *alarm2 = [EKAlarm alarmWithRelativeOffset:-86400]; // 1 Day    
        [myAlarmsArray addObject:alarm1];
        [myAlarmsArray addObject:alarm2];
        eventEK.alarms = myAlarmsArray;
        
        eventEK.title = eventEDV.title;
        eventEK.startDate = eventEDV.localStartDate;
        eventEK.endDate = eventEDV.localEndDate;
        
        [eventEK setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:eventEK span:EKSpanThisEvent error:&err];
        NSString* str = [[NSString alloc] initWithFormat:@"%@", eventEK.eventIdentifier];
        [eventEDV setGuid:str];
        
        [eventEDV setCalendarFlag:[NSNumber numberWithBool:YES]];
        
        // Save the change to the database.
        NSError *error2 = nil;
        if (![managedObjectContextEDV save:&error2]) {
            // Handle the error.
            NSLog(@"%@", @"ManagedObjectContext save error in addEventToCalendar - EventDetailView.m.");
        }

        // Pop alert to notify user that event has been added to the calendar.
        UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:@"Event Saved To Calendar" 
                                                           message:nil
                                                          delegate:nil 
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        
        [addAlert show];
        
        // Below is code to use a UIActionSheet instead of the UIAlertView that is coded above.
        /*
         UIActionSheet *addToCalendarAS = [[UIActionSheet alloc] initWithTitle:@"Event added to Calendar"
         delegate:nil 
         cancelButtonTitle:nil 
         destructiveButtonTitle:@"Return to Event" 
         otherButtonTitles:nil, nil];
         
         [addToCalendarAS showInView:self.view];
         */    
        
        self.addEventToCalendarLabel.text = @"Remove Event From Calendar";
    }
    // Else user has selected to remove an event from the calendar.
    else {
        // Pop alert to notify user that event has been added to the calendar.
        UIAlertView *removeAlert = [[UIAlertView alloc] initWithTitle:@"Remove Event From Calendar?" 
                                                           message:@"Are You Sure?"
                                                          delegate:self 
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:@"Yes", nil];
        
        [removeAlert show];
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    titleField.text = eventEDV.title;
    locationField.text = eventEDV.location;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d, yyyy"];
    NSString *startDateString = nil;
    startDateString = [dateFormatter stringFromDate:eventEDV.localStartDate];
    dateField.text = startDateString;
    
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *startTimeString = nil;
    startTimeString = [dateFormatter stringFromDate:eventEDV.localStartDate];
    timeField.text = startTimeString;
    
    if ([eventEDV.calendarFlag intValue] == 1) {
        self.addEventToCalendarLabel.text = @"Remove Event From Calendar";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIAlertView delegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Yes"])
    {
        // Access to managedObjectContext for saving changes to calendarFlag.
        AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *managedObjectContextEDV = appDelegate.managedObjectContext;
        
        EKEventStore* store = [[EKEventStore alloc] init];
        EKEvent* event2 = [store eventWithIdentifier:eventEDV.guid];
        if (event2 != nil) {  
            NSError* error = nil;
            [store removeEvent:event2 span:EKSpanThisEvent error:&error];
            [eventEDV setCalendarFlag:[NSNumber numberWithBool:NO]];
            [eventEDV setGuid:@""];
        }
        
        // Save the change to the database.
        NSError *error2 = nil;
        if (![managedObjectContextEDV save:&error2]) {
            // Handle the error.
            NSLog(@"%@", @"ManagedObjectContext save error in clickedButtonAtIndex - EventDetailView.m.");
        }
        self.addEventToCalendarLabel.text = @"Save Event To Calendar";
    }
}

@end
