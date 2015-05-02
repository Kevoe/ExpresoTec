//
//  SidebarViewController.m
//

#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "PhotoViewController.h"

@interface SidebarViewController ()
@property NSArray *menuItems;
@end

@implementation SidebarViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSString *pathPlist = [[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"];
    self.menuItems = [[NSArray alloc] initWithContentsOfFile: pathPlist];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController *) segue.destinationViewController;
    destViewController.title = [[self.menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    //NSLog(destViewController.title);
    //NSDictionary *object = self.menuItems[indexPath.row];
    //[destViewController setDetailItem:object];
}

@end
