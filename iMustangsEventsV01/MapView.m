//
//  MapView.m
//  iMustangsEventsV01
//
//  Created by Jackson, Jacob on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapView.h"
#import "TileOverlay.h"
#import "TileOverlayView.h"
#import "mapOptionViewController.h"
#import "CoreLocation/CoreLocation.h"
#import "MyAnnotation.h"


@implementation MapView

@synthesize navFromView;
@synthesize mapOptionButton;

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

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    TileOverlayView *view = [[TileOverlayView alloc] initWithOverlay:overlay];
    view.tileAlpha = 0.6;
    return [view autorelease];
}

- (void)viewWillAppear:(BOOL)animated
{
    map.mapType = MKMapTypeSatellite;
    MKCoordinateRegion CSC;
    
    // Defines the center point of the map
    CSC.center.latitude = 33.874809;
    CSC.center.longitude = -98.521129;
    
    // Defines the view,able area of the map. Lower numbers zoom in!
    CSC.span.latitudeDelta = .003;
    CSC.span.longitudeDelta = .003;
    [map setRegion:CSC animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSString *tileDirectory = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Tiles"];
    TileOverlay *overlay = [[TileOverlay alloc] initWithTileDirectory:tileDirectory];
    
    [map addOverlay:overlay];
}

- (void) viewDidLoad
{
    CLLocation *userLoc = map.userLocation.location;
    CLLocationCoordinate2D userCoordinate = userLoc.coordinate;
	
	NSLog(@"user latitude = %f",userCoordinate.latitude);
	NSLog(@"user longitude = %f",userCoordinate.longitude);
	
	map.delegate=self;
	
	NSMutableArray* annotations=[[NSMutableArray alloc] init];
	
	CLLocationCoordinate2D theCoordinate1;
    theCoordinate1.latitude = 37.786996;
    theCoordinate1.longitude = -122.419281;
	
	CLLocationCoordinate2D theCoordinate2;
    theCoordinate2.latitude = 37.810000;
    theCoordinate2.longitude = -122.477989;
	
	CLLocationCoordinate2D theCoordinate3;
    theCoordinate3.latitude = 37.760000;
    theCoordinate3.longitude = -122.447989;
	
	CLLocationCoordinate2D theCoordinate4;
    theCoordinate4.latitude = 37.80000;
    theCoordinate4.longitude = -122.407989;
	
	MyAnnotation* myAnnotation1=[[MyAnnotation alloc] init];
    
	myAnnotation1.coordinate=theCoordinate1;
	myAnnotation1.title=@"Rohan";
	myAnnotation1.subtitle=@"in the city";
	
	MyAnnotation* myAnnotation2=[[MyAnnotation alloc] init];
	
	myAnnotation2.coordinate=theCoordinate2;
	myAnnotation2.title=@"Vaibhav";
	myAnnotation2.subtitle=@"on a Bridge";
	
	MyAnnotation* myAnnotation3=[[MyAnnotation alloc] init];
	
	myAnnotation3.coordinate=theCoordinate3;
	myAnnotation3.title=@"Rituraaj";
	myAnnotation3.subtitle=@"in the forest";
	
	MyAnnotation* myAnnotation4=[[MyAnnotation alloc] init];
	
	myAnnotation4.coordinate=theCoordinate4;
	myAnnotation4.title=@"Amit";
	myAnnotation4.subtitle=@"at Russian Hill";
	
	[map addAnnotation:myAnnotation1];
	[map addAnnotation:myAnnotation2];
	[map addAnnotation:myAnnotation3];
	[map addAnnotation:myAnnotation4];
	
	[annotations addObject:myAnnotation1];
	[annotations addObject:myAnnotation2];
	[annotations addObject:myAnnotation3];
	[annotations addObject:myAnnotation4];
	

}

- (void)viewDidUnload
{
    [self setMapOptionButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)mapOptionButtonPressed:(id)sender {
    mapOptionViewController *mapOptions = [[mapOptionViewController alloc] initWithNibName:@"mapOptionViewController" bundle:nil];
    mapOptions.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentModalViewController:mapOptions animated:YES];
    
}
@end
