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
    theCoordinate1.latitude = 33.869764;
    theCoordinate1.longitude = -98.523454;
	
	CLLocationCoordinate2D theCoordinate2;
    theCoordinate2.latitude = 33.868857;
    theCoordinate2.longitude = -98.520627;
	
	CLLocationCoordinate2D theCoordinate3;
    theCoordinate3.latitude = 33.871778;
    theCoordinate3.longitude = -98.51964;
	
	CLLocationCoordinate2D theCoordinate4;
    theCoordinate4.latitude = 33.873905;
    theCoordinate4.longitude = -98.519468;
    
    CLLocationCoordinate2D theCoordinate5;
    theCoordinate5.latitude = 33.873969;
    theCoordinate5.longitude = -98.521193;
    
    CLLocationCoordinate2D theCoordinate6;
    theCoordinate6.latitude = 33.874773;
    theCoordinate6.longitude = -98.521131;
    
    CLLocationCoordinate2D theCoordinate7;
    theCoordinate7.latitude = 33.874754;
    theCoordinate7.longitude = -98.51934;
    
    CLLocationCoordinate2D theCoordinate8;
    theCoordinate8.latitude = 33.876228;
    theCoordinate8.longitude = -98.519755;
    
    CLLocationCoordinate2D theCoordinate9;
    theCoordinate9.latitude = 33.877033;
    theCoordinate9.longitude = -98.521228;
	
	CLLocationCoordinate2D theCoordinate10;
    theCoordinate10.latitude = 33.877548;
    theCoordinate10.longitude = -98.522439;
	
	CLLocationCoordinate2D theCoordinate11;
    theCoordinate11.latitude = 33.877762;
    theCoordinate11.longitude = -98.523237;
	
	CLLocationCoordinate2D theCoordinate12;
    theCoordinate12.latitude = 33.877643;
    theCoordinate12.longitude = -98.523894;
    
    CLLocationCoordinate2D theCoordinate13;
    theCoordinate13.latitude = 33.877388;
    theCoordinate13.longitude = -98.523194;
    
    CLLocationCoordinate2D theCoordinate14;
    theCoordinate14.latitude = 33.87713;
    theCoordinate14.longitude = -98.524056;
    
    CLLocationCoordinate2D theCoordinate15;
    theCoordinate15.latitude = 33.876945;
    theCoordinate15.longitude = -98.52328;
    
    CLLocationCoordinate2D theCoordinate16;
    theCoordinate16.latitude = 33.876014;
    theCoordinate16.longitude = -98.523234;
    
    CLLocationCoordinate2D theCoordinate17;
    theCoordinate17.latitude = 33.875548;
    theCoordinate17.longitude = -98.52317;
	
	CLLocationCoordinate2D theCoordinate18;
    theCoordinate18.latitude = 33.875069;
    theCoordinate18.longitude = -98.523151;
	
	CLLocationCoordinate2D theCoordinate19;
    theCoordinate19.latitude = 33.874878;
    theCoordinate19.longitude = -98.522346;
	
	CLLocationCoordinate2D theCoordinate20;
    theCoordinate20.latitude = 33.874263;
    theCoordinate20.longitude = -98.5223;
    
    CLLocationCoordinate2D theCoordinate21;
    theCoordinate21.latitude = 33.873685;
    theCoordinate21.longitude = -98.522432;
    
    CLLocationCoordinate2D theCoordinate22;
    theCoordinate22.latitude = 33.873375;
    theCoordinate22.longitude = -98.522966;
    
    CLLocationCoordinate2D theCoordinate23;
    theCoordinate23.latitude = 33.876945;
    theCoordinate23.longitude = -98.52328;
    
    CLLocationCoordinate2D theCoordinate24;
    theCoordinate24.latitude = 33.876014;
    theCoordinate24.longitude = -98.523234;
	
	MyAnnotation* myAnnotation1=[[MyAnnotation alloc] init];
    
	myAnnotation1.coordinate=theCoordinate1;
	myAnnotation1.title=@"Wellness Center";
	myAnnotation1.subtitle=@"in the city";
	
	MyAnnotation* myAnnotation2=[[MyAnnotation alloc] init];
	
	myAnnotation2.coordinate=theCoordinate2;
	myAnnotation2.title=@"President's House";
	myAnnotation2.subtitle=@"on a Bridge";
	
	MyAnnotation* myAnnotation3=[[MyAnnotation alloc] init];
	
	myAnnotation3.coordinate=theCoordinate3;
	myAnnotation3.title=@"DL Ligon Coliseum";
	myAnnotation3.subtitle=@"in the forest";
	
	MyAnnotation* myAnnotation4=[[MyAnnotation alloc] init];
	
	myAnnotation4.coordinate=theCoordinate4;
	myAnnotation4.title=@"Bolin Science Hall";
	myAnnotation4.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation5=[[MyAnnotation alloc] init];
	
	myAnnotation5.coordinate=theCoordinate5;
	myAnnotation5.title=@"Prothro Yeager";
	myAnnotation5.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation6=[[MyAnnotation alloc] init];
	
	myAnnotation6.coordinate=theCoordinate6;
	myAnnotation6.title=@"Clark Student Center";
	myAnnotation6.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation7=[[MyAnnotation alloc] init];
	
	myAnnotation7.coordinate=theCoordinate7;
	myAnnotation7.title=@"Moffett Library";
	myAnnotation7.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation8=[[MyAnnotation alloc] init];
	
	myAnnotation8.coordinate=theCoordinate8;
	myAnnotation8.title=@"Hardin Administration Building";
	myAnnotation8.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation9=[[MyAnnotation alloc] init];
    
	myAnnotation9.coordinate=theCoordinate9;
	myAnnotation9.title=@"Dillard College of Business Administration";
	myAnnotation9.subtitle=@"in the city";
	
	MyAnnotation* myAnnotation10=[[MyAnnotation alloc] init];
	
	myAnnotation10.coordinate=theCoordinate10;
	myAnnotation10.title=@"Bridwell Hall";
	myAnnotation10.subtitle=@"on a Bridge";
	
	MyAnnotation* myAnnotation11=[[MyAnnotation alloc] init];
	
	myAnnotation11.coordinate=theCoordinate11;
	myAnnotation11.title=@"Counseling Center";
	myAnnotation11.subtitle=@"in the forest";
	
	MyAnnotation* myAnnotation12=[[MyAnnotation alloc] init];
	
	myAnnotation12.coordinate=theCoordinate12;
	myAnnotation12.title=@"University Police Department";
	myAnnotation12.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation13=[[MyAnnotation alloc] init];
	
	myAnnotation13.coordinate=theCoordinate13;
	myAnnotation13.title=@"McGaha Hall";
	myAnnotation13.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation14=[[MyAnnotation alloc] init];
	
	myAnnotation14.coordinate=theCoordinate14;
	myAnnotation14.title=@"Bridwell Apartments";
	myAnnotation14.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation15=[[MyAnnotation alloc] init];
	
	myAnnotation15.coordinate=theCoordinate15;
	myAnnotation15.title=@"Instrumental Music Hall";
	myAnnotation15.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation16=[[MyAnnotation alloc] init];
	
	myAnnotation16.coordinate=theCoordinate16;
	myAnnotation16.title=@"McCullough Hall";
	myAnnotation16.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation17=[[MyAnnotation alloc] init];
    
	myAnnotation17.coordinate=theCoordinate17;
	myAnnotation17.title=@"Marchman Hall";
	myAnnotation17.subtitle=@"in the city";
	
	MyAnnotation* myAnnotation18=[[MyAnnotation alloc] init];
	
	myAnnotation18.coordinate=theCoordinate18;
	myAnnotation18.title=@"McCullough-Trigg Hall";
	myAnnotation18.subtitle=@"on a Bridge";
	
	MyAnnotation* myAnnotation19=[[MyAnnotation alloc] init];
	
	myAnnotation19.coordinate=theCoordinate19;
	myAnnotation19.title=@"Killingsworth Hall";
	myAnnotation19.subtitle=@"in the forest";
	
	MyAnnotation* myAnnotation20=[[MyAnnotation alloc] init];
	
	myAnnotation20.coordinate=theCoordinate20;
	myAnnotation20.title=@"Pierce Hall";
	myAnnotation20.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation21=[[MyAnnotation alloc] init];
	
	myAnnotation21.coordinate=theCoordinate21;
	myAnnotation21.title=@"Fain Instrumental Music Hall";
	myAnnotation21.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation22=[[MyAnnotation alloc] init];
	
	myAnnotation22.coordinate=theCoordinate22;
	myAnnotation22.title=@"Fain Fine Arts Center";
	myAnnotation22.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation23=[[MyAnnotation alloc] init];
	
	myAnnotation23.coordinate=theCoordinate23;
	myAnnotation23.title=@"Instrumental Music Hall";
	myAnnotation23.subtitle=@"at Russian Hill";
    
    MyAnnotation* myAnnotation24=[[MyAnnotation alloc] init];
	
	myAnnotation24.coordinate=theCoordinate24;
	myAnnotation24.title=@"McCullough Hall";
	myAnnotation24.subtitle=@"at Russian Hill";

	
	[map addAnnotation:myAnnotation1];
	[map addAnnotation:myAnnotation2];
	[map addAnnotation:myAnnotation3];
	[map addAnnotation:myAnnotation4];
    [map addAnnotation:myAnnotation5];
	[map addAnnotation:myAnnotation6];
	[map addAnnotation:myAnnotation7];
	[map addAnnotation:myAnnotation8];
    [map addAnnotation:myAnnotation9];
	[map addAnnotation:myAnnotation10];
	[map addAnnotation:myAnnotation11];
	[map addAnnotation:myAnnotation12];
    [map addAnnotation:myAnnotation13];
	[map addAnnotation:myAnnotation14];
	[map addAnnotation:myAnnotation15];
	[map addAnnotation:myAnnotation16];
    [map addAnnotation:myAnnotation17];
	[map addAnnotation:myAnnotation18];
	[map addAnnotation:myAnnotation19];
	[map addAnnotation:myAnnotation20];
    [map addAnnotation:myAnnotation21];
	[map addAnnotation:myAnnotation22];
	[map addAnnotation:myAnnotation23];
	[map addAnnotation:myAnnotation24];
	
	[annotations addObject:myAnnotation1];
	[annotations addObject:myAnnotation2];
	[annotations addObject:myAnnotation3];
	[annotations addObject:myAnnotation4];
    [annotations addObject:myAnnotation5];
	[annotations addObject:myAnnotation6];
	[annotations addObject:myAnnotation7];
	[annotations addObject:myAnnotation8];
    [annotations addObject:myAnnotation9];
	[annotations addObject:myAnnotation10];
	[annotations addObject:myAnnotation11];
	[annotations addObject:myAnnotation12];
    [annotations addObject:myAnnotation13];
	[annotations addObject:myAnnotation14];
	[annotations addObject:myAnnotation15];
	[annotations addObject:myAnnotation16];
    [annotations addObject:myAnnotation17];
	[annotations addObject:myAnnotation18];
	[annotations addObject:myAnnotation19];
	[annotations addObject:myAnnotation20];
    [annotations addObject:myAnnotation21];
	[annotations addObject:myAnnotation22];
	[annotations addObject:myAnnotation23];
	[annotations addObject:myAnnotation24];
	

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
