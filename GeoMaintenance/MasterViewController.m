//
//  MasterViewController.m
//  GeoMaintenance
//
//  Created by Steven Van der merwe on 2013/06/07.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MenuItem.h"

@interface MasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation MasterViewController
@synthesize menuOptions = _menuOptions;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [self loadMenuOptions];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
}

-(void)loadMenuOptions
{
    self.menuOptions = [[NSMutableArray alloc] init];
    
    [self.menuOptions addObject:[[MenuItem alloc] initWithLabel:@"1. Automatic Capture" :@"Auto Capture" :@"showAuto"]];
//    [self.menuOptions addObject:[[MenuItem alloc] initWithLabel:@"2. Manual Capture" :@"Manual Capture" :@"showManual"]];
//    [self.menuOptions addObject:[[MenuItem alloc] initWithLabel:@"3. How to submit geoInfo" :@"Submission Guide" :@"showGuide"]];
//    [self.menuOptions addObject:[[MenuItem alloc] initWithLabel:@"4. View Submitted geoInfos" :@"Submitted Issues" :@"showGuide"]];
    //[self.menuOptions addObject:@"1. Automatic Capture"];
    //[self.menuOptions addObject:@"2. Manual Capture"];
    //[self.menuOptions addObject:@"3. How to submit geoInfo"];
    //[self.menuOptions addObject:@"4. View Submitted geoInfos"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
         // Replace this implementation with code to handle the error appropriately.
         // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [[self.fetchedResultsController sections] count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
//    return [sectionInfo numberOfObjects];
    return self.menuOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //[self configureCell:cell atIndexPath:indexPath];
    cell.textLabel.text = [(MenuItem *)[self.menuOptions objectAtIndex:indexPath.row] label];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        MenuItem *object = [self.menuOptions objectAtIndex:indexPath.row];
        self.detailViewController.detailItem = object;
    }
    else {
        NSString *selectedSegueIdentifier = [[self.menuOptions objectAtIndex:indexPath.row] segueIdentifier];
        [self performSegueWithIdentifier:selectedSegueIdentifier sender:self];
    }
        
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    MenuItem *object = [self.menuOptions objectAtIndex:indexPath.row];
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//        [[segue destinationViewController] setDetailItem:object];
        [[segue destinationViewController] setDetailItem:object];        
    }
    if ([[segue identifier] isEqualToString:@"showAuto"]) {
        [[segue destinationViewController] setDetailItem:object];
    }
    
}

#pragma mark - Fetched results controller


@end
