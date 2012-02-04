//
//  mapViewController.h
//  iMustangs
//
//  Created by Eric Binnion on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface mapViewController : UIViewController <MKMapViewDelegate> {
    
    IBOutlet MKMapView *map;
}

@end
