//
//  SearchViewController.m
//  iMustangsEventsV01
//
//  Created by Jackson, Jacob on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "EventDetailView.h"

@implementation SearchViewController

@synthesize eventPicker;
@synthesize cancelButton;
@synthesize searchButton;
@synthesize navFromView;

- (IBAction)searchButtonPressed:(id)sender {
    [self.navFromView setString:@"EventSearchView"];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    eventType = [[NSArray alloc] initWithObjects:@"Football", @"Basketball", @"Golf", @"Tennis", @"Softball", @"Cross Country/Track", @"Soccer", @"Volleyball", nil];
    
    eventLocation = [[NSArray alloc] initWithObjects:@"All", @"Home", @"Away", nil];
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

#pragma mark -
#pragma mark Picker Datasource Protocol

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [eventType count];
    }
    else {
        return [eventLocation count];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch(component) {
            case 0: return 225;
            case 1: return 75;
        default: return 150;
    }
    
    //NOT REACHED
    return 100;
}


#pragma mark -
#pragma mark Picker Delegate Protocol

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [eventType objectAtIndex:row];
    }
    else {
        return [eventLocation objectAtIndex:row];
    }
    return nil;
}

@end
