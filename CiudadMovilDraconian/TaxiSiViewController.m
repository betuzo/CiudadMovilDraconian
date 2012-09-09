 //
//  TaxiSiViewController.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaxiSiViewController.h"
#import "SyncSingleton.h"
#import "TSTaxi.h"
#import "TSSitio.h"
#import "TSIncidente.h"
#import "TSObra.h"
#import "TSPasajero.h"

@interface TaxiSiViewController ()

@end

@implementation TaxiSiViewController


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
    [SyncSingleton getInstance].taxiSi = self;
}

-(IBAction)identificarTaxi:(id)sender{
    IdentificarTaxiViewController *identificarTaxi = [[IdentificarTaxiViewController alloc] initWithNibName:@"IdentificarTaxiViewController" bundle:nil];
    [self.navigationController pushViewController:identificarTaxi animated:YES];
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
        CiudadPinAnotation * ciudadAnnotation = annotation;
		annotationView.image = ciudadAnnotation.imageIcon;
		annotationView.annotation = annotation;
		annotationView.canShowCallout = YES;
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

-(void) addAnnotationSitios
{
    [self removeAnnotationByType:ANNOTATION_TYPE_SITIO];
    for (TSSitio *element in [TaxiSiService sitios]) {
        CLLocationCoordinate2D theCoordinate;
        theCoordinate.latitude = element.latitude;
        theCoordinate.longitude = element.longitude;
        
        CiudadPinAnotation* myAnnotation=[[CiudadPinAnotation alloc] init];
        
        myAnnotation.coordinate=theCoordinate;
        myAnnotation.title = [NSString stringWithFormat:@"%@", element.nombre];
        myAnnotation.description=[NSString stringWithFormat:@"%@", element.telefono];
        myAnnotation.imageIcon = [TaxiSiService imageByTypeAnnotetion:ANNOTATION_TYPE_SITIO];
        
        [_ciudadMapView addAnnotation:myAnnotation];
    }
}

-(void) addAnnotationIncidentes
{
    [self removeAnnotationByType:ANNOTATION_TYPE_INCIDENTE];
    for (TSIncidente *element in [TaxiSiService incidentes]) {
        CLLocationCoordinate2D theCoordinate;
        theCoordinate.latitude = element.latitude;
        theCoordinate.longitude = element.longitude;
        
        CiudadPinAnotation* myAnnotation=[[CiudadPinAnotation alloc] init];
        
        myAnnotation.coordinate=theCoordinate;
        myAnnotation.title = @"Incidente";
        myAnnotation.description=@"Incidente";
        myAnnotation.imageIcon = [TaxiSiService imageByTypeAnnotetion:ANNOTATION_TYPE_INCIDENTE];
        
        [_ciudadMapView addAnnotation:myAnnotation];
    }
} 


-(void) addAnnotationTaxis
{
    [self removeAnnotationByType:ANNOTATION_TYPE_TAXI];
    for (TSTaxi *element in [TaxiSiService taxis]) {
        CLLocationCoordinate2D theCoordinate;
        theCoordinate.latitude = element.latitude;
        theCoordinate.longitude = element.longitude;
        
        CiudadPinAnotation* myAnnotation=[[CiudadPinAnotation alloc] init];
        
        myAnnotation.coordinate=theCoordinate;
        myAnnotation.title = [NSString stringWithFormat:@"%@ - %@", element.placas, element.vehiculo];
        myAnnotation.description=[NSString stringWithFormat:@"%@ - %@", element.placas, element.vehiculo];
        myAnnotation.imageIcon = [TaxiSiService imageByTypeAnnotetion:ANNOTATION_TYPE_TAXI];
        
        [_ciudadMapView addAnnotation:myAnnotation];
    }
} 


-(void) addAnnotationObras
{
    [self removeAnnotationByType:ANNOTATION_TYPE_OBRA];
    for (TSObra *element in [TaxiSiService obras]) {
        CLLocationCoordinate2D theCoordinate;
        theCoordinate.latitude = element.latitude;
        theCoordinate.longitude = element.longitude;
        
        CiudadPinAnotation* myAnnotation=[[CiudadPinAnotation alloc] init];
        
        myAnnotation.coordinate=theCoordinate;
        myAnnotation.title = @"Obras";
        myAnnotation.imageIcon = [TaxiSiService imageByTypeAnnotetion:ANNOTATION_TYPE_OBRA];
        
        [_ciudadMapView addAnnotation:myAnnotation];
    }
}

-(void) removeAnnotationByType:(NSString *) type
{
    NSMutableArray *toRemove = [[NSMutableArray alloc] init];
    for (id annotation in _ciudadMapView.annotations){
        if ([annotation isKindOfClass:[CiudadPinAnotation class]]){
            CiudadPinAnotation *annotationCiudad = annotation;
            if([annotationCiudad.type isEqualToString:type]) 
                [toRemove addObject:annotation];
        }
    }
    [_ciudadMapView removeAnnotations:toRemove];
}

@end
