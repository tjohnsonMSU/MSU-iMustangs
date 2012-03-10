//
//  featuresViewController.m
//  iMustangs
//
//  Created by Eric Binnion on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "featuresViewController.h"

@implementation featuresViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    /*
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://docs.google.com/spreadsheet/embeddedform?formkey=dG5qR3F5LW5EWFBnamtqUjBQZ1dHS0E6MQ"]]];
     */
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

-(void)viewDidLoad
{
    [webSite addSubview:activityIndicator];
    [webSite loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:@"https://docs.google.com/spreadsheet/embeddedform?formkey=dG5qR3F5LW5EWFBnamtqUjBQZ1dHS0E6MQ"]]];
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(loading) userInfo:nil repeats:YES];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)loading
{
    if(!webSite.loading)
        [activityIndicator stopAnimating];
    else {
        [activityIndicator startAnimating];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [webView release];
    [super dealloc];
}
@end
