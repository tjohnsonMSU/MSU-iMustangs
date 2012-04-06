//
//  bandViewController.h
//  iMustangsEventsV01
//
//  Created by Eric Binnion on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bandViewController : UIViewController{
    IBOutlet UIWebView *webSite;
    IBOutlet UIActivityIndicatorView *activityIndicator;
   NSTimer *timer; 
}

@end
