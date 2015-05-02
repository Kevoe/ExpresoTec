//
//  ViewController.m
//

#import "MainViewController.h"
#import "SWRevealViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"News";
    
    //Sidebar button
    SWRevealViewController *revealViewController = self.revealViewController;
    if( revealViewController ){
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector(revealToggle:)];
        
        [self.rightSidebarButton setTarget: self.revealViewController];
        [self.rightSidebarButton setAction: @selector(rightRevealToggle:)];
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
