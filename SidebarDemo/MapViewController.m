//
//  MapViewController.m
//

#import "MapViewController.h"
#import "SWRevealViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.mapView setDelegate:self];
    self.mapView.showsUserLocation = YES;
    
    //Sidebar button
    SWRevealViewController *revealViewController = self.revealViewController;
    if( revealViewController ){
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector(revealToggle:)];
        
        [self.rightSidebarButton setTarget: self.revealViewController];
        [self.rightSidebarButton setAction: @selector(rightRevealToggle:)];
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self configureView];
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        
        //Titulo
        self.title = [self.detailItem objectForKey:@"ruta"];
        
        //Coordenadas iniciales
        CLLocationCoordinate2D initialLocation;
        initialLocation.latitude = [[self.detailItem objectForKey:@"latitudInicial"] doubleValue];
        initialLocation.longitude = [[self.detailItem objectForKey:@"longitudInicial"] doubleValue];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(initialLocation, 5000, 5000);
        [self.mapView setRegion:region animated:YES];
        
        //Pins/Anotaciones
        // Add an annotation
        NSArray *pines = [[NSArray alloc] initWithArray:[self.detailItem objectForKey:@"pings"]];
        
        CLLocationCoordinate2D ping;
        
        for(id object in pines){
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            ping.latitude = [[object objectForKey:@"latitud"] doubleValue];
            ping.longitude = [[object objectForKey:@"longitud"] doubleValue];
            point.coordinate = ping;
            point.title = [object objectForKey:@"titulo"];
            [self.mapView addAnnotation:point];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSegmentedType:(id)sender {
    if (self.segmMapType.selectedSegmentIndex == 0) {
        [self.mapView setMapType:MKMapTypeStandard];
    }
    else{
        [self.mapView setMapType:MKMapTypeHybrid];
    }
}
@end
