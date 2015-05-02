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
        //self.title = [self.detailItem objectForKey:@"ruta"];
        self.title = @"valle2";
        
        
        //Coordenadas iniciales
        CLLocationCoordinate2D initialLocation;
        initialLocation.latitude = 25.652751;
        initialLocation.longitude = -100.290467;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(initialLocation, 5000, 5000);
        [self.mapView setRegion:region animated:YES];
        
        //Pins/Anotaciones
        // Add an annotation
        CLLocationCoordinate2D ping;
        
        MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
        ping.latitude = 25.650840;
        ping.longitude = -100.378424;
        point1.coordinate = ping;
        point1.title = @"Av. Lomas del Valle";
        
        MKPointAnnotation *point2 = [[MKPointAnnotation alloc] init];
        ping.latitude = 25.638183;
        ping.longitude = -100.380206;
        point2.coordinate = ping;
        point2.title = @"Sierra Azul";
        
        MKPointAnnotation *point3 = [[MKPointAnnotation alloc] init];
        ping.latitude = 25.635162;
        ping.longitude = -100.370015;
        point3.coordinate = ping;
        point3.title = @"El Ángel (San Ángel)";
        
        MKPointAnnotation *point4 = [[MKPointAnnotation alloc] init];
        ping.latitude = 25.635151;
        ping.longitude = -100.358632;
        point4.coordinate = ping;
        point4.title = @"Planetario Alfa";
        
        MKPointAnnotation *point5 = [[MKPointAnnotation alloc] init];
        ping.latitude = 25.630531;
        ping.longitude = -100.335510;
        point5.coordinate = ping;
        point5.title = @"Alejandría";
        
        MKPointAnnotation *point6 = [[MKPointAnnotation alloc] init];
        ping.latitude = 25.645012;
        ping.longitude = -100.338939;
        point6.coordinate = ping;
        point6.title = @"Av. Lampazos";
        
        MKPointAnnotation *point7 = [[MKPointAnnotation alloc] init];
        ping.latitude = 25.652095;
        ping.longitude = -100.338885;
        point7.coordinate = ping;
        point7.title = @"Estacionamiento Plaza Fiesta San Agustìn";
        
        MKPointAnnotation *point8 = [[MKPointAnnotation alloc] init];
        ping.latitude = 25.652751;
        ping.longitude = -100.290467;
        point8.coordinate = ping;
        point8.title = @"Tecnológico de Monterrey";
        
        [self.mapView addAnnotation:point1];
        [self.mapView addAnnotation:point2];
        [self.mapView addAnnotation:point3];
        [self.mapView addAnnotation:point4];
        [self.mapView addAnnotation:point5];
        [self.mapView addAnnotation:point6];
        [self.mapView addAnnotation:point7];
        [self.mapView addAnnotation:point8];
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
