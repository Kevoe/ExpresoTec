//
//  MapViewController.m
//

#import "MapViewController.h"
#import "SWRevealViewController.h"

@interface MapViewController () <NSURLSessionDelegate>
@property (nonatomic, strong) NSURLSession *session;
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
    [self.mapView setMapType:MKMapTypeHybrid];
    
    //Request location from user
    
    
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
    [self fetchFeed];
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

//Pide los datos del servidor
- (void)fetchFeed
{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    
    //URL
    NSURL *url = [NSURL URLWithString:@"https://miataru-server-kevoe.c9.io/GetLocation"];
    
    //Device
    NSString *device = @"47C06029-BE62-4041-A20E-760E27751425";
    
    //json en string que se va a mandar
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"MiataruGetLocation\":[{\"Device\":\"%@\"}]}", device];
    //     NSLog(@"Request: %@", requestData);
    
    //Json que se va a mandar
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    //URLRequest con la URL y demas datos
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
         
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *datos = jsonObject[@"MiataruLocation"];
         
         NSLog(@"Device: %@", [datos[0] objectForKey:@"Device"]);
         NSLog(@"Latitude: %@", [datos[0] objectForKey:@"Latitude"]);
         NSLog(@"Longitude: %@", [datos[0] objectForKey:@"Longitude"]);
         NSLog(@"Timestamp: %@", [datos[0] objectForKey:@"Timestamp"]);
         
     }];
    [dataTask resume];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSegmentedType:(id)sender {
    if (self.segmMapType.selectedSegmentIndex == 0) {
        [self.mapView setMapType:MKMapTypeHybrid];
    }
    else{
        [self.mapView setMapType:MKMapTypeStandard];
    }
}
@end
