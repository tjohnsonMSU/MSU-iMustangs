//
//  SearchViewController.h
//  iMustangsEventsV01
//
//  Created by Jackson, Jacob on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EventListView;

@interface SearchViewController : UIViewController
<UIPickerViewDataSource, UIPickerViewDelegate> {
    UIPickerView *eventPicker;
    NSArray* eventType;
    NSArray* eventLocation;
    UIBarButtonItem *cancelButton;
    UIButton *searchButton;
    NSMutableString *navFromView;
}

@property (nonatomic, strong) IBOutlet UIPickerView *eventPicker;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, strong) IBOutlet UIButton *searchButton;
@property (nonatomic, strong) NSMutableString *navFromView;

- (IBAction)searchButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end
