//
//  EventDetailView.h
//  iMustangsEventsV01
//
//  Created by Seals, Shawn on 2/9/12.
//  Copyright (c) 2012 __MSU__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class Event;

@interface EventDetailView : UIViewController <UIActionSheetDelegate, UIAlertViewDelegate> {
    Event *eventEDV;
    UIBarButtonItem *backButton;
    UIButton *addToCalendarButton;
    UITextView *titleField;
    UILabel *dateField;
    UILabel *timeField;
    UILabel *locationField;
    UILabel *addEventToCalendarLabel;
}

@property (nonatomic, strong) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, strong) Event *eventEDV;
@property (nonatomic, strong) IBOutlet UIButton *addToCalendarButton;
@property (nonatomic, strong) IBOutlet UITextView *titleField;
@property (nonatomic, strong) IBOutlet UILabel *dateField;
@property (nonatomic, strong) IBOutlet UILabel *timeField;
@property (nonatomic, strong) IBOutlet UILabel *locationField;
@property (nonatomic, strong) IBOutlet UILabel *addEventToCalendarLabel;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)addEventToCalendar:(id)sender;

@end

