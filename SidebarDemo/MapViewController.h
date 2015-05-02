//
//  MapViewController.h
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightSidebarButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmMapType;

- (IBAction)btnSegmentedType:(id)sender;
@end
