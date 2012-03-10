//
//  bandViewController.h
//  iMustangs
//
//  Created by Eric Binnion on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bandViewController : UIViewController{
        IBOutlet UIActivityIndicatorView *activityIndicator;
        IBOutlet UIWebView *webSite;
        NSTimer *timer; 
}
@property (retain, nonatomic) IBOutlet UIWebView *webView;

@end
