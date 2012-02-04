//
//  mapViewController.m
//  iMustangs
//
//  Created by Eric Binnion on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "mapViewController.h"
#import "TileOverlay.h"
#import "TileOverlayView.h"

@implementation mapViewController

- (void)viewDidLoad
{
    NSString *tileDirectory = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Tiles"];
    TileOverlay *overlay = [[TileOverlay alloc] initWithTileDirectory:tileDirectory];
    [map addOverlay:overlay];
    
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

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    TileOverlayView *view = [[TileOverlayView alloc] initWithOverlay:overlay];
    view.tileAlpha = 0.6;
    return [view autorelease];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

@end
