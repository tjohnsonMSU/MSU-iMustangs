//
//  bandViewController.m
//  iMustangsEventsV01
//
//  Created by Eric Binnion on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "bandViewController.h"

@interface bandViewController ()

@end

@implementation bandViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [webSite addSubview:activityIndicator];
    [webSite loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:@"http://www.youtube.com/embed/XeIKnBDN4To"]]];
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(loading) userInfo:nil repeats:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Band";
}

- (void)viewDidUnload
{
    webSite = nil;
    activityIndicator = nil;
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
