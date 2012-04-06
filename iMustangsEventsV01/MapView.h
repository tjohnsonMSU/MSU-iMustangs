//
//  MapView.h
//  iMustangsEventsV01
//
//  Created by Jackson, Jacob on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapView : UIViewController <MKMapViewDelegate> {
    
    IBOutlet MKMapView *map;
    NSMutableString *navFromView;
}

@property (nonatomic, strong) NSMutableString *navFromView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *mapOptionButton;
- (IBAction)mapOptionButtonPressed:(id)sender;

@end
