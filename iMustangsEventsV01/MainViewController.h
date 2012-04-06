//
//  MainViewController.h
//  iMustangsEventsV01
//
//  Created by Seals, Shawn on 2/6/12.
//  Copyright (c) 2012 __MSU__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController 
<UIApplicationDelegate, NSXMLParserDelegate> {
    UIButton *mapButton;
    UIButton *eventsButton;
    UIButton *featureReqButton;
    UIActivityIndicatorView *spinner;
    UILabel *loadingEventDataLabel;
    UIButton *loadingEventDataButton;
    NSURLConnection *eventFeedConnection;
    NSMutableData *eventData;
    NSManagedObjectContext *managedObjectContext;
    
    // These variables are used during parsing.
    NSMutableArray *currentParseBatch;
    NSMutableString *currentParsedCharacterData;
    BOOL accumulatingParsedCharacterData;
    BOOL didAbortParsing;
    
    // Used during parsing and for saving to Event NSManagedObject.
    NSMutableString *currentEventTitle;
    NSMutableString *currentEventDescript;
    NSMutableString *currentEventGUID;
    NSMutableString *currentEventLocation;
    NSMutableString *currentEventWebLink;
    NSDate *currentEventLocalStartDate;
    NSDate *currentEventLocalEndDate;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) IBOutlet UIButton *eventsButton;
@property (strong, nonatomic) IBOutlet UIButton *featureReqButton;
@property (strong, nonatomic) IBOutlet UIButton *bandButton;
@property (strong, nonatomic) IBOutlet UIButton *developerButton;
@property (nonatomic, strong) NSURLConnection *eventFeedConnection;
@property (nonatomic, strong) NSMutableData *eventData; // The data returned from the NSURLConnection
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, strong) IBOutlet UILabel *loadingEventDataLabel;
@property (nonatomic, strong) IBOutlet UIButton *loadingEventDataButton;

- (void)handleError:(NSError *)error;
- (IBAction)eventsButtonPressed:(id)sender;
- (IBAction)mapButtonPressed:(id)sender;
- (IBAction)featureReqPressed:(id)sender;
- (IBAction)bandButtonPressed:(id)sender;
- (IBAction)developerButtonPressed:(id)sender;

@end
