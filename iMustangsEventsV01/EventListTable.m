//
//  EventListTable.m
//  iMustangsEventsV01
//
//  Created by Seals, Shawn on 2/10/12.
//  Copyright (c) 2012 __MSU__. All rights reserved.
//

#import "EventListTable.h"
#import "Event.h"
#import "AppDelegate.h"
#import "EventDetailView.h"

@implementation EventListTable

@synthesize navFromView;


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

- (NSFetchedResultsController *)resultsController {
    // If we've already initialized our results controller, just return it.
    if (resultsController_ != nil) {
        return resultsController_;
    }
    
    // Request for results controller.
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    // Set fetch predicate to exclude events that have already occured.
    NSDate *today = [NSDate date];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(localStartDate >= %@)", today];
    [request setPredicate:predicate];
        
    // Test predicate. Not needed in final.
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(calendarFlag == 0)"];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"localStartDate" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    resultsController_ = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"event_list.cache"];
    resultsController_.delegate = self;
    
    NSError *error;
    BOOL success = [resultsController_ performFetch:&error];
    if (!success) {
        // Handle the error.
    }
    return resultsController_;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"Events";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.resultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[self.resultsController sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event *eventCell = [self.resultsController objectAtIndexPath:indexPath];
    
    // Each subview in the cell will be identified by a unique tag.
    static NSUInteger const kTitleLabelTag = 2;
    static NSUInteger const kDateLabelTag = 3;
    static NSUInteger const kAddedToCalendarTag = 4;
    
    // Declare references to the subviews which will display the event data.
    UILabel *titleLabel = nil;
    UILabel *dateLabel = nil;
    UILabel *addedToCalendarLabel = nil;
    
    // Do not use default deque and reuse method in order to redraw cells after changes made.
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 18, 285, 20)];
    titleLabel.tag = kTitleLabelTag;
    titleLabel.font = [UIFont boldSystemFontOfSize:13];
    if ([eventCell.calendarFlag intValue] == 1) {
        titleLabel.textColor = [UIColor darkGrayColor];
    }
    [cell.contentView addSubview:titleLabel];
        
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 80, 15)];
    dateLabel.tag = kDateLabelTag;
    dateLabel.font = [UIFont systemFontOfSize:10];
    if ([eventCell.calendarFlag intValue] == 1) {
        dateLabel.textColor = [UIColor darkGrayColor];
    }
    [cell.contentView addSubview:dateLabel];
    
    addedToCalendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 3, 195, 15)];
    addedToCalendarLabel.tag = kAddedToCalendarTag;
    addedToCalendarLabel.font = [UIFont systemFontOfSize:10];
    addedToCalendarLabel.textColor = [UIColor darkGrayColor];
    addedToCalendarLabel.textAlignment = UITextAlignmentRight;
    [cell.contentView addSubview:addedToCalendarLabel];
    
    // Configure the cell...
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"EEE, MMM d 'at' HH:mm"];
    
    titleLabel.text = eventCell.title;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d"];
    
    dateLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:eventCell.localStartDate]];
    
    if ([eventCell.calendarFlag intValue] == 1) {
        addedToCalendarLabel.text = @"This Event Is Saved To Calendar";
    }
    else {
        addedToCalendarLabel.text = @"";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    EventDetailView *eventDetailVC = [[EventDetailView alloc] initWithNibName:@"EventDetailView" bundle:nil];
    // ...
    // Send the addToCalendarVC a copy of the selected event.
    eventDetailVC.eventEDV = [self.resultsController objectAtIndexPath:indexPath];
    
    [self presentModalViewController:eventDetailVC animated:YES];
}

@end
