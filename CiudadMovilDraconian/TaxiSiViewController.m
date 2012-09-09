//
//  TaxiSiViewController.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaxiSiViewController.h"
#import "SyncSingleton.h"

@interface TaxiSiViewController ()

@end

@implementation TaxiSiViewController

@synthesize taxiSiNavigationController = _taxiSiNavigationController;

@synthesize coordinate = _coordinate;

@synthesize ciudadMapView = _ciudadMapView;

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect rectButton;
    
    rectButton.size.width = 40;
    rectButton.size.height = 40;
    
    rectButton.origin.x = 0;
    rectButton.origin.y = 0;
    
    UIButton *leftButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *rightButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButtonItem addTarget:self action:@selector(pedirTaxi:) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonItem setFrame:rectButton];
    [rightButtonItem setBackgroundImage:[UIImage imageNamed:@"toolbar-pedir-taxi"] forState:UIControlStateNormal];
    
    [leftButtonItem addTarget:self action:@selector(verIncidenciasObras:) forControlEvents:UIControlEventTouchUpInside];
    [leftButtonItem setFrame:rectButton];
    [leftButtonItem setBackgroundImage:[UIImage imageNamed:@"toolbar-incidentes"] forState:UIControlStateNormal];
    
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButtonItem];
    
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButtonItem];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

    [[SyncSingleton getInstance] initSync];
}

- (void) pedirTaxi:(id) sender
{

}

- (void) verIncidenciasObras:(id) sender
{
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [[SyncSingleton getInstance] endSync];
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - mapview delegate 

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *AnnotationViewID = @"annotationViewID";
	
    MKAnnotationView *annotationView = (MKAnnotationView *)[_ciudadMapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
	
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
	
	if ([annotation isKindOfClass:[CiudadPinAnotation class]]) {
		annotationView.image = [UIImage imageNamed:@"pinQ.png"];
		annotationView.annotation = annotation;
		annotationView.canShowCallout = YES;
		UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		annotationView.rightCalloutAccessoryView = rightButton;
		
		
		return annotationView;
	}
	else{
	    return nil;
	}
    
	
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	
	//StoresDescriptionViewController *storesDetailViewController = [[StoresDescriptionViewController alloc]initWithNibName:@"StoresDescriptionViewController" bundle:nil];
	//[self.navigationController pushViewController:storesDetailViewController animated:YES];
}

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self showUserLocation];
}

-(void)showUserLocation
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    CLLocationCoordinate2D location;
    location.latitude = [_ciudadMapView userLocation].coordinate.latitude;
    location.longitude = [_ciudadMapView userLocation].coordinate.longitude;
    [TaxiSiService userLogged].latitude = location.latitude;
    [TaxiSiService userLogged].longitude = location.longitude;
    region.span = span;
    region.center = location;
    [_ciudadMapView setRegion:region animated:YES];    
}
@end
