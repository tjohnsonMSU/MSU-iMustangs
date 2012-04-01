//
//  MapView.m
//  iMustangsEventsV01
//
//  Created by Jackson, Jacob on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapView.h"

@implementation MapView

@synthesize navFromView;

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
    self.navigationItem.title = @"Map View";
    
    map.mapType = MKMapTypeSatellite;
    MKCoordinateRegion CSC;
    
    // Defines the center point of the map
    CSC.center.latitude = 33.874809;
    CSC.center.longitude = -98.521129;
    
    // Defines the view,able area of the map. Lower numbers zoom in!
    CSC.span.latitudeDelta = .003;
    CSC.span.longitudeDelta = .003;
    [map setRegion:CSC animated:YES];
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

@end
